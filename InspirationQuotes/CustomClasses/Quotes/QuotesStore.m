//
//  QuotesStore.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/18/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import "QuotesStore.h"
#import "NSMutableArray+RandomObject.h"
#import "DayQuoteDBManager.h"

#define POSITION_ID 0
#define POSITION_QUOTE 1
#define POSITION_AUTHOR 2

@implementation QuotesStore

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark Publuc methods

+ (Quote *)getRandomQuote {
    Quote *returnQuote = [[Quote alloc]init];
    NSArray *rawDataArray = [[DayQuoteDBManager sharedInstance] getRanomdQuoteData];
    NSArray *dataArray = [rawDataArray firstObject];
    returnQuote = [QuotesStore composeQuoteFromRawArray:dataArray];
    
    return returnQuote;
}

+ (Quote *)getRandomQuoteForAppleWatch {
    Quote *returnQuote = [[Quote alloc]init];
    NSArray *rawDataArray = [[DayQuoteDBManager sharedInstance] getRanomdQuoteDataForAppleWatch];
    NSArray *dataArray = [rawDataArray firstObject];
    returnQuote = [QuotesStore composeQuoteFromRawArray:dataArray];
    
    return returnQuote;
}

+ (BOOL)addToFavoriteQuoteWithID:(NSInteger)qID {
    eTypeQuoteStatus result = [[DayQuoteDBManager sharedInstance] addQuoteToFavoriteWithID:qID];
    return (result == eTypeQuoteStatusSuccessAdded);
}

+ (BOOL)removeFromFavoriteQuoteWithID:(NSInteger)qID {
    eTypeQuoteStatus result = [[DayQuoteDBManager sharedInstance] removeQuoteFromFavoriteWithID:qID];
    return (result == eTypeQuoteStatusSuccessRemoved);
}

+ (NSArray *)getAllFavoritesQuotes {
    NSMutableArray *returnQuoteArray = [NSMutableArray new];
    NSArray *rawDataArray = [[DayQuoteDBManager sharedInstance]  getAllFavoritedQuotesID];
    for (NSNumber *qID in rawDataArray) {
        NSArray *rawQuoteData = [[DayQuoteDBManager sharedInstance] getQuoteDataWithID:[qID integerValue]];
        rawQuoteData = [rawQuoteData firstObject];
        if (rawQuoteData) {
            Quote *favoritedQuote = [QuotesStore composeQuoteFromRawArray:rawQuoteData];
            [returnQuoteArray addObject:favoritedQuote];
        }
    }
    return [returnQuoteArray copy];
}

+ (BOOL)isQuoteFavoritedWithID:(NSInteger)qID {
    return [[DayQuoteDBManager sharedInstance] isQuoteFavoritedWitID:qID];
}

#pragma mark Private Methods

+ (Quote *)composeQuoteFromRawArray:(NSArray *)rawArray {
    Quote *returnQuote = [[Quote alloc]init];
    if (!rawArray) return returnQuote;
    NSString *qID = (NSString *)rawArray[POSITION_ID];
    returnQuote.qID = [qID integerValue];
    returnQuote.quote = (NSString *)rawArray[POSITION_QUOTE];
    returnQuote.author = (NSString *)rawArray[POSITION_AUTHOR];
    returnQuote.favorited = [[DayQuoteDBManager sharedInstance] isQuoteFavoritedWitID:returnQuote.qID];
    return returnQuote;
}

@end
