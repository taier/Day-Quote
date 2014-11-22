//
//  QuoteDetailViewController.h
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/22/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Quote;

@interface QuoteDetailViewController : UIViewController
/**
 * Setup controller with quote text and author
 *
 * @param Quote quote to sho
 */
- (void)setUpWithQuote:(Quote *)quote;

@end
