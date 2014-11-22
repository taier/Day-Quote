//
//  NSMutableArray+RandomObject.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/18/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import "NSMutableArray+RandomObject.h"

@implementation NSMutableArray (RandomObject)

- (id) randomObject
{
    if ([self count] == 0) {
        return nil;
    }
    return [self objectAtIndex: arc4random() % [self count]];
}

@end
