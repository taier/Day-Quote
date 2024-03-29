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

// Screen Sizes

typedef enum {
    AdvertBannerSizeSmartPortrait = 1,
    AdvertBannerSizeSmartLandscape = 2,
} AdvertBannerSize;

// Macros
#ifndef SINGLETON_GCD
#define SINGLETON_GCD(classname)                        \
\
+ (classname *)sharedInstance {                      \
\
static dispatch_once_t pred;                        \
__strong static classname * sharedInstance = nil;\
dispatch_once( &pred, ^{                            \
sharedInstance = [[self alloc] init]; });    \
return sharedInstance;                           \
}
#endif

// IDs
#define LEADERBOARD_ID @"000"
#define IN_APP_PURCHASE_ID @"CoffeeDonationDayQuoteApp"
#define GOOGLE_ADVERT_ID @"" // Replace this ad unit ID with your own ad unit ID.

// User defaults keys
#define USER_DEFAULTS_ADS_KEY @"AdsRemoved"
