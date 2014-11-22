//
//  Quote.h
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/22/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Quote : NSObject

@property (assign, nonatomic) NSInteger qID;
@property (strong, nonatomic) NSString *quote;
@property (strong, nonatomic) NSString *author;
@property (assign, nonatomic) BOOL favorited;

@end
