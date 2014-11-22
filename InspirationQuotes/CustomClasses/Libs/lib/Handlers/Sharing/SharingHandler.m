/*
 The MIT License (MIT)
 
 Copyright (c) 2014 deniss.kaibagarovs@gmail.com, Denis Kaibagarovs.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

@import Social;
#import "SharingHandler.h"

@implementation SharingHandler {
    UIDocumentInteractionController *docController;
}

+ (void)shareFacebookInViewController:(UIViewController *)viewController andText:(NSString *)text {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:text];
        [viewController presentViewController:controller animated:YES completion:Nil];
    }
}

+ (void)shareTwitterInViewController:(UIViewController *)viewController andText:(NSString *)text {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:text];
        [viewController presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (void)shareInstagramInViewController:(UIViewController*)viewController withImage:(UIImage *)image andText:(NSString *)text {
    //Remember Image must be larger than 612x612 size if not resize it.
    NSURL *instagramURL = [NSURL URLWithString:@"instagram://app"];
    
    if([[UIApplication sharedApplication] canOpenURL:instagramURL])
    {

        NSString *documentDirectory=[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSString *saveImagePath=[documentDirectory stringByAppendingPathComponent:@"ExportImage.ig"];
        NSData *imageData=UIImagePNGRepresentation(image);
        [imageData writeToFile:saveImagePath atomically:YES];
        
        NSURL *imageURL = [NSURL fileURLWithPath:saveImagePath];
        
        docController = [[UIDocumentInteractionController alloc]init];
        docController.delegate = self;
        docController.UTI= @"com.instagram.photo";
        
        docController.annotation=[NSDictionary dictionaryWithObjectsAndKeys:text,@"InstagramCaption", nil];
        
        [docController setURL:imageURL];
        
        CGRect rect = CGRectMake(0, 0, 0, 0);
        [docController presentOpenInMenuFromRect:rect inView:viewController.view animated:YES];
    }
    else
    {
        NSLog (@"Instagram not found");
    }
}

@end
