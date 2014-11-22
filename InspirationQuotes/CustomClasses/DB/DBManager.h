//
//  DBManager.h
//  SQLite3DBSample
//
//  Created by Deniss Kaibagarovs on 11/20/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DBManager : NSObject

@property (nonatomic, strong) NSMutableArray *arrayColumnNames;
@property (nonatomic, assign) int affectedRows;
@property (nonatomic, assign) long long lastInsertedRowID;

- (instancetype)initWithDatabaseFileName:(NSString *)dbFileName;
- (NSArray *)loadDataFromBD:(NSString *)query;
- (BOOL)executeQuery:(NSString *)query;

@end
