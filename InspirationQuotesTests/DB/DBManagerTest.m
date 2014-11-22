//
//  DBManagerTest.m
//  SQLite3DBSample
//
//  Created by Deniss Kaibagarovs on 11/21/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "DBManager.h"

#define DB_NAME_TEST @"DBManagerTestDB.sql"
#define INSERT_QUERY @"INSERT INTO test VALUES(null, 'testName','testLastName');"
#define GET_QUERY @"SELECT * FROM test"
#define REMOVE_QUERY @"DELETE FROM test WHERE id=%ld"

@interface DBManagerTest : XCTestCase {
    DBManager *dbManager;
}

@end

@implementation DBManagerTest

- (void)setUp {
    [super setUp];
    dbManager = [[DBManager alloc]initWithDatabaseFileName:DB_NAME_TEST];
    
}

- (void)tearDown {
    // Remove Test DB from production folder
    // Set the document directory path to the documentDirectory property
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

#pragma mark Public Methods Tests
- (void)testInit {
    XCTAssert(dbManager);
}

- (void)testExecuteQuery {
    XCTAssert([dbManager executeQuery:INSERT_QUERY]);
}

- (void)testSelectQuery {
    XCTAssert([dbManager loadDataFromBD:GET_QUERY]);
}

- (void)testDeleteQuery {
    [dbManager executeQuery:INSERT_QUERY];
    NSInteger lastExecutedRow = (int)dbManager.lastInsertedRowID;
    NSString *query = [NSString stringWithFormat:REMOVE_QUERY,lastExecutedRow];
    XCTAssert([dbManager executeQuery:query]);
    
}

#pragma mark Private Methods Tests

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}


@end
