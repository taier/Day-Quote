//
//  DBManager.m
//  SQLite3DBSample
//
//  Created by Deniss Kaibagarovs on 11/20/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//


/*
 REFACTOR
 UNIT TESTS!!
*/

#import "DBManager.h"
#import <sqlite3.h>

@interface DBManager ()

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFileName;
@property (nonatomic, strong) NSMutableArray *arrayResults;

- (BOOL)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;
- (void)copyDatabaseIntoDocumentsDirectory;

@end

@implementation DBManager

#pragma mark Public Methods

- (NSArray *)loadDataFromBD:(NSString *)query {
    // Run the query an indicate that is not exucutable;
    // The query string is coverted to a char * object
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    
    // Returned the loadedd result
    return (NSArray *)self.arrayResults;
}

- (BOOL)executeQuery:(NSString *)query {
    // Run the query and indicate that is executable
    return [self runQuery:[query UTF8String] isQueryExecutable:YES];
}

- (instancetype)initWithDatabaseFileName:(NSString *)dbFileName {
    self = [super init];
    if (self) {
        // Set the document directory path to the documentDirectory property
        NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [path firstObject];
        
        // Keep the database filename
        self.databaseFileName = dbFileName;
        
        // Copy the database file into the documents directory if necessary
        [self copyDatabaseIntoDocumentsDirectory];
    }
    
    return self;
}

#pragma mark Private Methods

#warning REFACTOR THIS SHIT!
- (BOOL)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable {
    
    [self cleanStuff];
    
    // Set the database file path
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFileName];
    
    // Create a sqlite object
    sqlite3 *sqlite3Database;
    
    // Open the database
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if (openDatabaseResult != SQLITE_OK) {
        NSLog(@"%s",sqlite3_errmsg(sqlite3Database));
        return NO;
    }
    // Declare a sqlite3_stmt object in witch will be stored the query after having been compiled into SQLite statement
    sqlite3_stmt *compiledStatement;
    
    // Load all data from database to memory
    BOOL prepareStamentResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
    if (prepareStamentResult != SQLITE_OK) {
        NSLog(@"%s",sqlite3_errmsg(sqlite3Database));
        return NO;
    }
    
    // Check if query is non-executable
    if (!queryExecutable) {
        // In this case data must be loaded from the database
        // Declare an array to keep the data for each fetched row
        NSMutableArray *arrayDataRow;
        
        // Loop through the results and add them to the results array row by row
        while (sqlite3_step(compiledStatement) == SQLITE_ROW) {
            // Initialize the mutable array that will contain the data of a fetched row
            arrayDataRow = [NSMutableArray new];
            
            // Get the total number of colums
            int totalColums = sqlite3_column_count(compiledStatement);
            
            // Go through all colums and fetch each column data
            for (int i = 0; i < totalColums; i++) {
                // Convert the column data to text (characters)
                char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                
                // If there are contents in the current column (field) then add them to the current row array
                if (dbDataAsChars) {
                    [arrayDataRow addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                }
                
                // Keep the current column name
                if (self.arrayColumnNames.count != totalColums) {
                    dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                    [self.arrayColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                }
            }
            
            // Store each fethced data row in the results array, but first check if there is actually data
            if (arrayDataRow.count) {
                [self.arrayResults addObject:arrayDataRow];
            }
        }
    } else {
        // This is the case of an executalbe query (insert, update, etc)
        int executeQueryResults = sqlite3_step(compiledStatement);
        if (executeQueryResults == SQLITE_DONE) {
            // Keep the affected rows
            self.affectedRows = sqlite3_changes(sqlite3Database);
            
            // Kee the last inserted row ID
            self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
        } else {
            // If could not execute the query show the error message on the debugger
            NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
        }
    }
    // Release the complited statement from memory
    sqlite3_finalize(compiledStatement);
    
    // Close the database
    sqlite3_close(sqlite3Database);
    
    return YES;
}

- (void)cleanStuff {
    // Initialize the results array
    [self cleanArray:self.arrayResults];
    self.arrayResults = [NSMutableArray new];
    
    // Initialize the results array
    [self cleanArray:self.arrayResults];
    self.arrayResults = [NSMutableArray new];
    
    // Initialize the column names array
    [self cleanArray:self.arrayColumnNames];
    self.arrayColumnNames = [NSMutableArray new];
}

- (void)cleanArray:(NSMutableArray *)array {
    if (array && [array isKindOfClass:[NSMutableArray class]]) {
        [array removeAllObjects];
        array = nil;
    }
}

- (void)copyDatabaseIntoDocumentsDirectory {
    // Check if database file exists in the documents directory
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFileName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        // The database file does not exist in the documents directiry, so copy it form bundle
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFileName];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

@end
