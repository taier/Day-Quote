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
    workStatus = [[DayQuoteDBManager sharedInstance] addQuoteToFavoriteWithID:1];
    XCTAssertEqual(workStatus, eTypeQuoteSuccessAdded);
}

- (void)testRemoveQuoteFromFavorite {
    eTypeQuoteStatus workStatus;
    [[DayQuoteDBManager sharedInstance] addQuoteToFavoriteWithID:1];
    workStatus = [[DayQuoteDBManager sharedInstance] removeQuoteFromFavoriteWithID:1];
    XCTAssertEqual(workStatus, eTypeQuoteSuccessRemoved);
}

@end
