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

@interface QuotesStoreTest : XCTestCase

@end

@implementation QuotesStoreTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testQuoteExist {
    Quote *quote = [QuotesStore getRandomQuote];
    XCTAssert(quote.quote);
}

- (void)testAuthorExist {
    Quote *quote = [QuotesStore getRandomQuote];
    XCTAssert(quote.author);
}

- (void)testRandomQuotes {
    ///TBD Imporve this test
    Quote *quote1 = [QuotesStore getRandomQuote];
    Quote *quote2 = [QuotesStore getRandomQuote];
    XCTAssertNotEqualObjects(quote1.quote, quote2.quote);
}

- (void)testRandomQuotesAuthors {
    Quote *quote1 = [QuotesStore getRandomQuote];
    Quote *quote2 = [QuotesStore getRandomQuote];
    
    if ([quote1.quote isEqualToString:quote2.quote]) {
        XCTAssertEqualObjects(quote1.author, quote2.author);
    } else {
        XCTAssertNotEqual(quote1.author, quote2.author);
    }
}

- (void)testAddToFavoriteQuoteWithID {
    XCTAssert([QuotesStore addToFavoriteQuoteWithID:2]);
}

- (void)testRemoveFromFavoriteQuoteWithID {
    [QuotesStore addToFavoriteQuoteWithID:2];
    XCTAssert([QuotesStore removeFromFavoriteQuoteWithID:2]);
}

- (void)testGetAllFavoritesQuotes {
#warning REFACTOR THIS
    //CeanUp TEMP
    [QuotesStore removeFromFavoriteQuoteWithID:1];
    [QuotesStore removeFromFavoriteQuoteWithID:2];
    [QuotesStore removeFromFavoriteQuoteWithID:3];
    [QuotesStore removeFromFavoriteQuoteWithID:4];
    
    [QuotesStore addToFavoriteQuoteWithID:1];
    NSArray *returnArray = [QuotesStore getAllFavoritesQuotes];
    XCTAssertEqual(returnArray.count, 1);
    [QuotesStore addToFavoriteQuoteWithID:2];
    [QuotesStore addToFavoriteQuoteWithID:3];
    [QuotesStore addToFavoriteQuoteWithID:4];
    returnArray = [QuotesStore getAllFavoritesQuotes];
    XCTAssertEqual(returnArray.count, 4);
}

- (void)testIsQuoteFavoritedWithID {
    [QuotesStore addToFavoriteQuoteWithID:10];
    XCTAssert([QuotesStore isQuoteFavoritedWithID:10]);
}

@end
