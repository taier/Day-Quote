//
//  ViewController.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/18/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import "ViewController.h"
#import "IndieGamesHelper.h"
#import "IndieGamesHelperDefines.h"
#import "ModalTransitionAnimator.h"
#import "QuotesStore.h"

#define SWHIPE_TEXT_ANIMATION_RESTART_TIME 10
#define SWHIPE_TEXT_ANIMATION_FIRST_TIME 2
#define QUOTE_CHANGE_ANIMATION_DURATION 0.7
#define FAVORITE_TIME_ANIMATION 0.3
#define FAVORITE_BUTTON_ACTIVE_COLOR [UIColor blackColor]
#define FAVORITE_BUTTON_INACTIVE_COLOR [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1]

/* TBD
 Move Instagram sharing in to lib
 Implement DQDBManager as shared manager
 Create prefix file
 */

#define APP_NAME @"DayQuote"

@interface ViewController () <UIDocumentInteractionControllerDelegate,UIViewControllerTransitioningDelegate> {
    UIDocumentInteractionController *docController;
    Quote *currentQuote;
    BOOL refreshedBySwipe;
}
@property (weak, nonatomic) IBOutlet UILabel *labelSwipeToRefresh;
@property (weak, nonatomic) IBOutlet UILabel *labelQuote;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthor;
@property (weak, nonatomic) IBOutlet UIView *viewQuote;
@property (weak, nonatomic) IBOutlet UIButton *buttonFavorite;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelSwipeToRefresh.alpha = 0;
    self.buttonFavorite.adjustsImageWhenHighlighted = NO;
    [self performSelector:@selector(animateHelpTextForSwipe) withObject:nil afterDelay:SWHIPE_TEXT_ANIMATION_FIRST_TIME];
    [self changeQuoteAnimated:NO];
    [self setupGesture];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)setupGesture {
    UISwipeGestureRecognizer *gestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [gestureRecognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [self.view addGestureRecognizer:gestureRecognizer];
}
- (IBAction)onFavoriteButtonPress:(id)sender {
    if (currentQuote.favorited) {
        [QuotesStore removeFromFavoriteQuoteWithID:currentQuote.qID];
        currentQuote.favorited = NO;
        [self changeFavoriteButtonToActive:NO];
    } else {
        [QuotesStore addToFavoriteQuoteWithID:currentQuote.qID];
        currentQuote.favorited = YES;
        [self changeFavoriteButtonToActive:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onFacebookButtonPress:(id)sender {
    [[IndieGamesHelper sharedInstance] shareFacebookInViewController:self andText:[self getSharingText]];
}
- (IBAction)onTwitterButtonPress:(id)sender {
    [[IndieGamesHelper sharedInstance] shareTwitterInViewController:self andText:[self getSharingText]];
}
- (IBAction)onInstagramButtonPress:(id)sender {
    //Remember Image must be larger than 612x612 size if not resize it.
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    
    if([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {
        
        UIGraphicsBeginImageContextWithOptions(self.viewQuote.bounds.size, self.viewQuote.opaque, 0.0);
        [self.viewQuote.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage* theImage=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        NSString *documentDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *saveImagePath=[documentDirectory stringByAppendingPathComponent:@"ExportImage.ig"];
        NSData *imageData=UIImagePNGRepresentation(theImage);
        [imageData writeToFile:saveImagePath atomically:YES];
        
        NSURL *imageURL = [NSURL fileURLWithPath:saveImagePath];
        
        docController = [[UIDocumentInteractionController alloc]init];
        docController.delegate = self;
        docController.UTI= @"com.instagram.photo";
        
        docController.annotation=[NSDictionary dictionaryWithObjectsAndKeys:@"Image Taken via @DayQuote",@"InstagramCaption", nil];
        
        [docController setURL:imageURL];
        
        CGRect rect = CGRectMake(0, 0, 0, 0);
        [docController presentOpenInMenuFromRect:rect inView:self.view animated:YES];
    }
    else
    {
        NSLog (@"Instagram not found");
    }

}

- (NSString *)getSharingText {
    return [NSString stringWithFormat:@"%@ - %@ #%@", self.labelQuote.text, self.labelAuthor.text, APP_NAME];
}

#pragma mark Transition

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController* controller = (UIViewController*)segue.destinationViewController;
    
    controller.transitioningDelegate = self;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.modalPresentationCapturesStatusBarAppearance = YES;
}

- (IBAction)unwindToRootViewController:(UIStoryboardSegue*)unwindSegue {
}

#pragma mark - Custom transitions

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [ModalTransitionAnimator new];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [ModalTransitionAnimator new];
}

#pragma mark Text animation

- (void)animateHelpTextForSwipe {
    if (refreshedBySwipe) return;
    self.labelSwipeToRefresh.alpha = 0;
    [UIView animateWithDuration:3 animations:^{
        self.labelSwipeToRefresh.alpha = 1;
    } completion:^(BOOL fin){
        [UIView animateWithDuration:2 animations:^{
            self.labelSwipeToRefresh.alpha = 0;
        } completion:^(BOOL fin){
        }];
    }];
    
    [self performSelector:@selector(animateHelpTextForSwipe) withObject:nil afterDelay:SWHIPE_TEXT_ANIMATION_RESTART_TIME];
}

- (void)changeQuoteAnimated:(BOOL)animated {
    currentQuote = [QuotesStore getRandomQuote];
    if (animated) {
        [UIView animateWithDuration:QUOTE_CHANGE_ANIMATION_DURATION animations:^{
            self.labelQuote.alpha = 0;
            self.labelAuthor.alpha = 0;
            self.buttonFavorite.alpha = 0;
        } completion:^(BOOL fin){
            self.labelQuote.text = currentQuote.quote;
            self.labelAuthor.text = currentQuote.author;
            [self changeFavoriteButtonToActive:currentQuote.favorited];
            [UIView animateWithDuration:QUOTE_CHANGE_ANIMATION_DURATION animations:^{
                self.labelQuote.alpha = 1;
                self.labelAuthor.alpha = 1;
                self.buttonFavorite.alpha = 1;
            } completion:^(BOOL fin){
            }];
        }];
    } else {
        self.labelQuote.text = currentQuote.quote;
        self.labelAuthor.text = currentQuote.author;
        [self changeFavoriteButtonToActive:currentQuote.favorited];
    }
}

#pragma mark Gesture 

-(void)swipeHandler:(UISwipeGestureRecognizer *)recognizer {
    refreshedBySwipe = YES;
    [self changeQuoteAnimated:YES];
}

#pragma mark Private Methods

- (void)changeFavoriteButtonToActive:(BOOL)active {
    if (active) {
        self.buttonFavorite.tintColor = FAVORITE_BUTTON_ACTIVE_COLOR;
        
    } else {
        self.buttonFavorite.tintColor = FAVORITE_BUTTON_INACTIVE_COLOR;
    }
}

@end
