//
//  DQDBManager.h
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/21/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Quote;

typedef enum : NSUInteger {
    eTypeQuoteAlreadyFavorited = 1,
    eTypeQuoteSuccessAdded = 2,
    eTypeQuoteSuccessRemoved = 3,
    eTypeQuoteNotFavorited = 4
} eTypeQuoteStatus;

@interface DayQuoteDBManager : NSObject
/**
 * Return DQBDManager initialized object
 *
 */
+ (DayQuoteDBManager *)sharedInstance;

/**
 * Add quote to favorite Table in DB
 *
 * @param quoteID ID of the quote to add
 * @return Status of performed work
 */
- (eTypeQuoteStatus)addQuoteToFavoriteWithID:(NSInteger)quoteID; // Unit Test exist
/**
 * Remove quote from favorite Table in ID
 *
 * @param quoteID ID of he quote to remove
 * @return Status of performed work
 */
- (eTypeQuoteStatus)removeQuoteFromFavoriteWithID:(NSInteger)quoteID; // Unit Test exist
/**
 * Return all favorited quotes IDs
 *
 * @return NSArray array with IDs of quotes. IDs is NSNumber, so use iniValue to get real ID
 */
- (NSArray *)getAllFavoritedQuotesID;
/**
 * Return Quote object with required qoute ID
 *
 * @param quoteID ID of the quote to return
 * @return Quote object
 */
- (Quote *)getQuoteWithID:(NSInteger)quoteID;

@end
