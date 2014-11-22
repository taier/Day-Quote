//
//  DQDBManagerTest.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/22/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DayQuoteDBManager_PrivateMethods.h"

#define DB_NAME_TEST @"DayQuoteDBManagerTestDB.sql"

@interface DayQuoteDBManagerTest : XCTestCase {
    DayQuoteDBManager *dbManager;
}

@end

@implementation DayQuoteDBManagerTest

- (void)setUp {
    [super setUp];
    dbManager = [[DayQuoteDBManager alloc]initWithDBName:DB_NAME_TEST];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *testDBPath = [path firstObject];
    testDBPath = [testDBPath stringByAppendingPathComponent:DB_NAME_TEST];
    if([[NSFileManager defaultManager] fileExistsAtPath:testDBPath]) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:testDBPath error:&error];
        if (error) {
            NSLog(@"CANT REMOVE TEST DB. REASON - %@",[error localizedDescription]);
        }
    }
    [super tearDown];
}

- (void)testAddQuoteToFavorite {
    eTypeQuoteStatus workStatus;
    workStatus = [dbManager addQuoteToFavoriteWithID:1];
    XCTAssertEqual(workStatus, eTypeQuoteStatusSuccessAdded);
}

- (void)testRemoveQuoteFromFavorite {
    eTypeQuoteStatus workStatus;
    [dbManager addQuoteToFavoriteWithID:1];
    workStatus = [dbManager removeQuoteFromFavoriteWithID:1];
    XCTAssertEqual(workStatus, eTypeQuoteStatusSuccessRemoved);
}

- (void)testGetAllFavoriteQuotesID {
     [dbManager addQuoteToFavoriteWithID:1];
     [dbManager addQuoteToFavoriteWithID:2];
     [dbManager addQuoteToFavoriteWithID:3];
    NSArray *resultArray = [dbManager getAllFavoritedQuotesID];
    XCTAssertEqual(resultArray.count, 3);
}

- (void)testGetQuoteDataWithID {
    
    [dbManager addQuoteWithText:@"TestText" author:@"TestAuthor"];
    NSArray *resultArray = [dbManager getQuoteDataWithID:1];
    XCTAssertEqual(resultArray.count, 1);
}

- (void)testIsQuoteFavoritedWitID {
    [dbManager addQuoteToFavoriteWithID:2];
    BOOL favorited = [dbManager isQuoteFavoritedWitID:2];
    XCTAssert(favorited);
    BOOL notFavorited = [dbManager isQuoteFavoritedWitID:999];
    XCTAssertFalse(notFavorited);
}

- (void)testGetRandomQuoteData {
    [dbManager addQuoteWithText:@"TestText" author:@"TestAuthor"];
    [dbManager addQuoteWithText:@"TestText" author:@"TestAuthor"];
    [dbManager addQuoteWithText:@"TestText" author:@"TestAuthor"];
    [dbManager addQuoteWithText:@"TestText" author:@"TestAuthor"];
    
    NSArray *returnArray = [dbManager getRanomdQuoteData];
    XCTAssert(returnArray.count);
}

@end
