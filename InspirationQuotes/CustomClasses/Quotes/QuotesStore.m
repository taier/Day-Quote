//
//  QuotesStore.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/18/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import "QuotesStore.h"
#import "NSMutableArray+RandomObject.h"

#define QUOTE_KEY @"Quote_Key"
#define AUTHOR_KEY @"Author_Key"

@implementation QuotesStore {
    NSMutableArray *quotesDictArray;
    NSString *currentQuoteAuthor;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        quotesDictArray = [self getRandomQuotesDictsArray];
    }
    return self;
}

- (NSMutableArray *)getRandomQuotesDictsArray {
    NSMutableArray *returnArray = [NSMutableArray new];
    [returnArray addObject:@{QUOTE_KEY:@"Some Cool quote", AUTHOR_KEY: @"Some Cool Author"}];
    [returnArray addObject:@{QUOTE_KEY:@"Some Cool quote 2",AUTHOR_KEY: @"Some Cool Author 2"}];
    
    return returnArray;
}

- (NSString *)quote {
    NSDictionary *quoteDict = [quotesDictArray randomObject];
    if (!quoteDict || ![quoteDict objectForKey:QUOTE_KEY]) { return @"Life is what happens to you while you’re busy making other plans"; } // John Lennon
    currentQuoteAuthor = [quoteDict objectForKey:AUTHOR_KEY];
    return [quoteDict objectForKey:QUOTE_KEY];
}

- (NSString *)author {
    return (currentQuoteAuthor) ? currentQuoteAuthor : @"John Lennon";
}

@end
