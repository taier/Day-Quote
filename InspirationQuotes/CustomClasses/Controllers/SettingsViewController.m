//
//  SettingsViewController.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/18/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import "SettingsViewController.h"
#import "AppDelegate.h"
#import "IndieGamesHelper.h"
#import "ModalTransitionAnimator.h"

#define LIKED_QUOTES_SEGUE_ID @"LIKED_QUOTES_SEQUE_ID"

@interface SettingsViewController () <IndieGamesHelperDeleate, UIViewControllerTransitioningDelegate> {
    AppDelegate *appDelegate;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
@property (weak, nonatomic) IBOutlet UISwitch *switchNotification;
@property (weak, nonatomic) IBOutlet UILabel *lablePrice;
@property (weak, nonatomic) IBOutlet UIButton *buttonCoffe;

@property (weak, nonatomic) IBOutlet UILabel *labelNotification;
@property (weak, nonatomic) IBOutlet UILabel *labelLikedQuote;
@property (weak, nonatomic) IBOutlet UIButton *buttonFavorite;


@end

@implementation SettingsViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [[UIApplication sharedApplication] delegate];
    [self setUpCoffe];
    self.buttonBack.transform = CGAffineTransformMakeRotation(M_PI_2);
    [self.switchNotification setOn:[appDelegate notificationsOn]];
}

- (void)viewDidLayoutSubviews {
    [self setUpCorrectAppereance];
}

- (void)setUpCoffe {
    if([[[NSUserDefaults standardUserDefaults] valueForKey:USER_DEFAULTS_ADS_KEY] boolValue]) {
        self.lablePrice.text = @"Thank You!";
        [self.buttonCoffe setUserInteractionEnabled:NO];
        [self.buttonCoffe setTintColor:[UIColor grayColor]];
    }
}

- (IBAction)onBackButtonPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)switchValueChange:(id)sender {
    if (self.switchNotification.isOn) {
        [appDelegate setNofificationFromSettings:YES];
    } else {
        [appDelegate removeNotification];
    }
}

- (IBAction)onLikedQuotesButtonPress:(id)sender {
    [self performSegueWithIdentifier:LIKED_QUOTES_SEGUE_ID sender:nil];
}

- (IBAction)onPurchageButtonPress:(id)sender {
    [IndieGamesHelper sharedInstance].delegate = self;
    [[IndieGamesHelper sharedInstance] purchaseRemovingAD];
}

- (void)removeADSSuccess {
    [self setUpCoffe];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController* controller = (UIViewController*)segue.destinationViewController;
    
    controller.transitioningDelegate = self;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.modalPresentationCapturesStatusBarAppearance = YES;
}


#pragma mark Animation Transition

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [ModalTransitionAnimator new];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [ModalTransitionAnimator new];
}

#warning BURN THIS SHIT WITH FIRE ASAP!!!
- (void)setUpCorrectAppereance {
    CGRect screenBound = [[UIScreen mainScreen] bounds];
    CGSize screenSize = screenBound.size;
    CGFloat correctY = screenSize.height / 3.8;
    // Place stuff on correct Y
    [self.labelNotification setFrame:CGRectMake(self.labelNotification.frame.origin.x,
                                               correctY,
                                               self.labelNotification.frame.size.width,
                                               self.labelNotification.frame.size.height)];
    
    [self.labelLikedQuote setFrame:CGRectMake(self.labelLikedQuote.frame.origin.x,
                                                correctY,
                                                self.labelLikedQuote.frame.size.width,
                                                self.labelLikedQuote.frame.size.height)];
    
    [self.buttonFavorite setFrame:CGRectMake(self.buttonFavorite.frame.origin.x,
                                              correctY + 43,
                                              self.buttonFavorite.frame.size.width,
                                              self.buttonFavorite.frame.size.height)];
    
    [self.switchNotification setFrame:CGRectMake(self.switchNotification.frame.origin.x,
                                             correctY + 50,
                                             self.switchNotification.frame.size.width,
                                             self.switchNotification.frame.size.height)];
    
}

@end
