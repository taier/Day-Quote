//
//  DQDBManager.h
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/21/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    eTypeQuoteStatusAlreadyFavorited = 1,
    eTypeQuoteStatusSuccessAdded = 2,
    eTypeQuoteStatusSuccessRemoved = 3,
    eTypeQuoteStatusNotFavorited = 4,
    eTypeQuoteStatusError = 5,
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
- (eTypeQuoteStatus)addQuoteToFavoriteWithID:(NSInteger)quoteID; // Unit Test +
/**
 * Remove quote from favorite Table in ID
 *
 * @param quoteID ID of he quote to remove
 * @return Status of performed work
 */
- (eTypeQuoteStatus)removeQuoteFromFavoriteWithID:(NSInteger)quoteID; // Unit Test +
/**
 * Return all favorited quotes IDs
 *
 * @return NSArray array with IDs of quotes. IDs is NSNumber, so use iniValue to get real ID
 */
- (NSArray *)getAllFavoritedQuotesID; // Unit Test +
/**
 * Return NSArray with data from required qoute ID
 *
 * @param quoteID ID of the quote to return
 * @return NSArray with data from required quote ID
 */
- (NSArray *)getQuoteDataWithID:(NSInteger)quoteID; // Unit Test +
/**
 * Check if quote is favorited
 *
 * @param quoteID ID of the quote to check
 * @return YES if favorited, No if not
 */
- (BOOL)isQuoteFavoritedWitID:(NSInteger)quoteID; // Unit Test +
/**
 * Retur random Quote Data from DB
 *
 * @return NSArray with data
 */
- (NSArray *)getRanomdQuoteData;

- (NSArray *)getRanomdQuoteDataForAppleWatch;

@end
