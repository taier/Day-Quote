//
//  FavorQuotesTableViewController.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/22/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import "FavorQuotesTableViewController.h"
#import "ModalTransitionJumpRightAnimator.h"
#import "QuoteDetailViewController.h"
#import "QuotesStore.h"

#define CELL_ID @"cell"
#define QUOTE_DESCRIPTION_SEGUE_ID @"QUOTE_DESCRIPTION_SEGUE"

@interface FavorQuotesTableViewController () <UITableViewDataSource, UITableViewDelegate, UIViewControllerTransitioningDelegate> {
    NSArray *_quotesArray;
    Quote *_selectedQuote;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonBack;
@property (weak, nonatomic) IBOutlet UILabel *labelNoLikedQuotes;

@end

@implementation FavorQuotesTableViewController

#pragma mark Live Circle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Rotate Button
    self.buttonBack.transform = CGAffineTransformMakeRotation(M_PI_2);
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initQuoteArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Buttons

- (IBAction)onBackButtonPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Private Methods

- (void)initQuoteArray {
    _quotesArray = [QuotesStore getAllFavoritesQuotes];
    if (!_quotesArray.count) {
        self.labelNoLikedQuotes.hidden = NO;
        self.tableView.userInteractionEnabled = NO;
    } else {
        self.labelNoLikedQuotes.hidden = YES;
        self.tableView.userInteractionEnabled = YES;
    }
    [self.tableView reloadData];
}

#pragma mark Table View Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _quotesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Dequeue the cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID];
    Quote *quote = [_quotesArray objectAtIndex:indexPath.row];
    
    // Set Apperance
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.f];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.f];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    
    // Set Content
    cell.textLabel.text = quote.quote;
    cell.detailTextLabel.text = quote.author;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedQuote = [_quotesArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:QUOTE_DESCRIPTION_SEGUE_ID sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark Animation Transition

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    QuoteDetailViewController* controller = (QuoteDetailViewController*)segue.destinationViewController;
    [controller setUpWithQuote:_selectedQuote];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [ModalTransitionJumpRightAnimator new];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [ModalTransitionJumpRightAnimator new];
}

@end
