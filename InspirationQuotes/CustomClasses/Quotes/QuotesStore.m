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

+ (Quote *)getRandomQuote {
    Quote *returnQuote = [[Quote alloc]init];
    NSArray *rawDataArray = [[DayQuoteDBManager sharedInstance] getRanomdQuoteData];
    NSArray *dataArray = [rawDataArray firstObject];
    returnQuote.qID = [(NSString *)dataArray[POSITION_ID] integerValue];
    returnQuote.quote = (NSString *)dataArray[POSITION_QUOTE];
    returnQuote.author = (NSString *)dataArray[POSITION_AUTHOR];
    returnQuote.favorited = [[DayQuoteDBManager sharedInstance] isQuoteFavoritedWitID:returnQuote.qID];
    
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

@end
