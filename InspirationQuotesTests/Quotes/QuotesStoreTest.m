//
//  QuotesStoreTest.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/18/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "QuotesStore.h"

@interface QuotesStoreTest : XCTestCase {
    QuotesStore *qStore;
}

@end

@implementation QuotesStoreTest

- (void)setUp {
    [super setUp];
    qStore = [[QuotesStore alloc]init];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testQuoteExist {
    XCTAssert(qStore.quote);
}

- (void)testAuthorExist {
    XCTAssert(qStore.author);
}

- (void)testRandomQuotes {
    ///TBD Imporve this test
    XCTAssertNotEqualObjects(qStore.quote, qStore.quote);
}

- (void)testRandomQuotesAuthors {
    NSString *firstQuote = qStore.quote;
    NSString *firstAuthor = qStore.author;
    NSString *secondQuote = qStore.quote;
    NSString *secondAuthor = qStore.author;
    
    if ([firstQuote isEqualToString:secondQuote]) {
        XCTAssertEqualObjects(firstAuthor, secondAuthor);
    } else {
        XCTAssertNotEqual(firstAuthor, secondAuthor);
    }
}

@end
