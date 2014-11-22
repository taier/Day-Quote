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
#define DB_INSERT_FAVORITE_QUERY @"INSERT INTO liked_quotes VALUES(%ld);"
#define BB_REMOVE_FAVORITE_QUERY @"DELETE FROM liked_quotes WHERE id=%ld;"

static DayQuoteDBManager *_sharedInstce = nil;
@interface DayQuoteDBManager () {
    DBManager *_dbManager;
}

@end

@implementation DayQuoteDBManager

+ (DayQuoteDBManager *)sharedInstance {
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedInstce = [[DayQuoteDBManager alloc]initWithDBName:DB_NAME_PRODUCT];
    });
    
    return _sharedInstce;
}

- (instancetype)initWithDBName:(NSString *)DBName {
    self = [super init];
    if (self) {
        _dbManager = [[DBManager alloc]initWithDatabaseFileName:DBName];
    }
    return self;
}

- (eTypeQuoteStatus)addQuoteToFavoriteWithID:(NSInteger)quoteID {
    
    NSString *query = [NSString stringWithFormat:DB_INSERT_FAVORITE_QUERY,(long)quoteID];
    return ([_dbManager executeQuery:query]) ? eTypeQuoteSuccessAdded : eTypeQuoteAlreadyFavorited;
}

- (eTypeQuoteStatus)removeQuoteFromFavoriteWithID:(NSInteger)quoteID {
    NSString *query = [NSString stringWithFormat:BB_REMOVE_FAVORITE_QUERY,(long)quoteID];
    return ([_dbManager executeQuery:query]) ? eTypeQuoteSuccessRemoved : eTypeQuoteNotFavorited;
}

@end
