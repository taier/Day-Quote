//
//  QuoteDetailViewController.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/22/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import "QuoteDetailViewController.h"
#import "IndieGamesHelper.h"
#import "QuotesStore.h"

#define APP_NAME @"DayQuote"
#define FAVORITE_BUTTON_ACTIVE_COLOR [UIColor blackColor]
#define FAVORITE_BUTTON_INACTIVE_COLOR [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1]

@interface QuoteDetailViewController () {
    Quote *_diplayedQuote;
}
@property (weak, nonatomic) IBOutlet UIButton *buttonFavorite;
@property (weak, nonatomic) IBOutlet UIView *viewQuote;
@property (weak, nonatomic) IBOutlet UILabel *labelQuote;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthor;

@end

@implementation QuoteDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpAppereance];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onBackButtonPress:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Public Methods

- (void)setUpWithQuote:(Quote *)quote {
    _diplayedQuote = quote;
}

#pragma mark Private Methods

- (void)setUpAppereance {
    self.labelQuote.text = _diplayedQuote.quote;
    self.labelAuthor.text = _diplayedQuote.author;
    [self changeFavoriteButtonToActive:YES];
}

- (void)changeFavoriteButtonToActive:(BOOL)active {
    if (active) {
        self.buttonFavorite.tintColor = FAVORITE_BUTTON_ACTIVE_COLOR;
    } else {
        self.buttonFavorite.tintColor = FAVORITE_BUTTON_INACTIVE_COLOR;
    }
}

- (UIImage *)getImageOfQuote {
    UIGraphicsBeginImageContextWithOptions(self.viewQuote.bounds.size, self.viewQuote.opaque, 0.0);
    [self.viewQuote.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* theImage=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (NSString *)getSharingText {
    return [NSString stringWithFormat:@"%@ - %@ #%@", self.labelQuote.text, self.labelAuthor.text, APP_NAME];
}

#pragma mark Buttons

- (IBAction)onFacebookShareButtonPress:(id)sender {
      [[IndieGamesHelper sharedInstance] shareFacebookInViewController:self andText:[self getSharingText]];
}
- (IBAction)onTwitterShareButtonPress:(id)sender {
    [[IndieGamesHelper sharedInstance] shareTwitterInViewController:self andText:[self getSharingText]];
}
- (IBAction)onInstagramShareButtonPress:(id)sender {
    
    self.buttonFavorite.hidden = YES;
    UIImage *imageToShare = [self getImageOfQuote];
    self.buttonFavorite.hidden = NO;
    
    [[IndieGamesHelper sharedInstance] shareInstagramInViewController:self withImage:imageToShare andText:@"Today Quote via @DayQuote"];
}
- (IBAction)onFavoriteButtonPress:(id)sender {
    if (_diplayedQuote.favorited) {
        [QuotesStore removeFromFavoriteQuoteWithID:_diplayedQuote.qID];
        _diplayedQuote.favorited = NO;
        [self changeFavoriteButtonToActive:NO];
    } else {
        [QuotesStore addToFavoriteQuoteWithID:_diplayedQuote.qID];
        _diplayedQuote.favorited = YES;
        [self changeFavoriteButtonToActive:YES];
    }
}

@end
