//
//  InterfaceController.m
//  Day Quote WatchKit Extension
//
//  Created by Deniss Kaibagarovs on 3/14/15.
//  Copyright (c) 2015 Deniss Kaibagarovs. All rights reserved.
//

#import "InterfaceController.h"
#import "QuotesStore.h"

@interface InterfaceController()
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *labelMain;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    Quote *quote = [QuotesStore getRandomQuoteForAppleWatch];
    [self.labelMain setText:quote.quote];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}
- (IBAction)onRefreshButtonPress {
    Quote *quote = [QuotesStore getRandomQuoteForAppleWatch];
    [self.labelMain setText:quote.quote];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



