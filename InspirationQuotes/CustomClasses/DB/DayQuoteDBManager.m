//
//  DQDBManager.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/21/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import "DayQuoteDBManager.h"
#import "DBManager.h"
#import "Quote.h"

#define DB_NAME_PRODUCT @"PRODUCT_DB.sql"

// Favorite
#define DB_INSERT_FAVORITE_QUERY @"INSERT INTO liked_quotes VALUES(%ld);"
#define DB_REMOVE_FAVORITE_QUERY @"DELETE FROM liked_quotes WHERE id=%ld;"
#define DB_GETALL_FAVORITE_QUERY @"SELECT * FROM liked_quotes;"
#define DB_CHECK_FAVORITE_QUERY @"SELECT * FROM liked_quotes WHERE id=%ld;"

// Quotes
#define DB_GET_QUOTE_QUERY @"SELECT * FROM quotes WHERE id = %ld"
#define DB_INSERT_QUOTE_QUERY @"INSERT INTO quotes VALUES(null,'%@','%@');"
#define DB_GET_RANDOM_QUOTE_QUERY @"SELECT * FROM quotes ORDER BY RANDOM() LIMIT 1;"

static DayQuoteDBManager *_sharedInstce = nil;
@interface DayQuoteDBManager () {
    DBManager *_dbManager;
}

@end

@implementation DayQuoteDBManager

#pragma mark Live Circle

+ (DayQuoteDBManager *)sharedInstance {
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstce = [[DayQuoteDBManager alloc] initWithDBName:DB_NAME_PRODUCT];
    });
    
    return _sharedInstce;
}

- (instancetype)initWithDBName:(NSString *)DBName {
    self = [super init];
    if (self) {
        _dbManager = [[DBManager alloc] initWithDatabaseFileName:DBName];
    }
    return self;
}

#pragma mark Public Methods

- (eTypeQuoteStatus)addQuoteToFavoriteWithID:(NSInteger)quoteID {
    
    NSString *query = [NSString stringWithFormat:DB_INSERT_FAVORITE_QUERY,(long)quoteID];
    return ([_dbManager executeQuery:query]) ? eTypeQuoteStatusSuccessAdded : eTypeQuoteStatusAlreadyFavorited;
}

- (eTypeQuoteStatus)removeQuoteFromFavoriteWithID:(NSInteger)quoteID {
    NSString *query = [NSString stringWithFormat:DB_REMOVE_FAVORITE_QUERY,(long)quoteID];
    return ([_dbManager executeQuery:query]) ? eTypeQuoteStatusSuccessRemoved : eTypeQuoteStatusNotFavorited;
}

- (NSArray *)getAllFavoritedQuotesID {
    NSMutableArray *returnArray = [NSMutableArray new];
    NSArray *requestedArray = [_dbManager loadDataFromBD:DB_GETALL_FAVORITE_QUERY];
    for (NSArray *insideArray in requestedArray) {
        NSString *dataFromDB = [insideArray firstObject];
        if (dataFromDB) {
            [returnArray addObject:[NSNumber numberWithInt:[dataFromDB intValue]]];
        }
    }
    return [returnArray copy];
}

- (NSArray *)getQuoteDataWithID:(NSInteger)quoteID {
    NSString *query = [NSString stringWithFormat:DB_GET_QUOTE_QUERY, quoteID];
    NSArray *requstedArray = [_dbManager loadDataFromBD:query];
    return requstedArray;
}

- (BOOL)isQuoteFavoritedWitID:(NSInteger)quoteID {
    NSString *query = [NSString stringWithFormat:DB_CHECK_FAVORITE_QUERY, quoteID];
    NSArray *requestedArray = [_dbManager loadDataFromBD:query];
    
    return requestedArray.count;
}

- (NSArray *)getRanomdQuoteData {
    return [_dbManager loadDataFromBD:DB_GET_RANDOM_QUOTE_QUERY];
}

- (NSArray *)getRanomdQuoteDataForAppleWatch {
    return [_dbManager loadDataForAppleWatchFromBD:DB_GET_RANDOM_QUOTE_QUERY];
}

#pragma mark Private Methods

- (eTypeQuoteStatus)addQuoteWithText:(NSString *)text author:(NSString *)author {
    NSString *query = [NSString stringWithFormat:DB_INSERT_QUOTE_QUERY,text,author];
    return ([_dbManager executeQuery:query]) ? eTypeQuoteStatusSuccessAdded : eTypeQuoteStatusError;
}

@end
