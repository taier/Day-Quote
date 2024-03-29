//
//  QuotesStore.h
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/18/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quote.h"

@interface QuotesStore : NSObject
/**
 * Return random Quote from DB
 *
 * @return Random Quote object
 */
+ (Quote *)getRandomQuote; // Unit test +

/**
 * Add record to liked_quotes about new quote
 *
 * @param qID ID of quote to add as favotired
 * @return YES if success
 */

+ (Quote *)getRandomQuoteForAppleWatch;

+ (BOOL)addToFavoriteQuoteWithID:(NSInteger)qID; // Unit test +
/**
 * Remove recond from liked_quotes about quote
 *
 * @param qID ID of quote to add as favorited
 * @return YES if success
 */
+ (BOOL)removeFromFavoriteQuoteWithID:(NSInteger)qID;  // Unit test +
/**
 * Compose array of quotes objects, from user favorited quotes
 *
 * @return NSArray with Quotes objects
 */
+ (NSArray *)getAllFavoritesQuotes;
/**
 * Check if quote is favorited
 *
 * @param qID ID of quote to check
 * @return YES is favorited
 */
+ (BOOL)isQuoteFavoritedWithID:(NSInteger)qID;
@end
