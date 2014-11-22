//
//  DQDBManager_PrivateMethods.h
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/22/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import "DayQuoteDBManager.h"

@interface DayQuoteDBManager ()

- (instancetype)initWithDBName:(NSString *)DBName;
- (eTypeQuoteStatus)addQuoteWithText:(NSString *)text author:(NSString *)author ;

@end
