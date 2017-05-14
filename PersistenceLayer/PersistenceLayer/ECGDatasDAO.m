//
//  ECGDatasDAO.m
//  PersistenceLayer
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ECGDatasDAO.h"

@implementation ECGDatasDAO
static ECGDatasDAO *manager = nil;

-(int)insertData:(ECGDatas *)model andtableName:(NSString *)tableName{
    NSString *filePath = [self applicationDocumentsDirectoryPath];
    
    if(sqlite3_open([filePath UTF8String], &db) != SQLITE_OK){
        NSAssert(NO, @"数据库打开失败");
        [self closeDatabase];
        return 0;
    }
    else{
        NSString *insertSql1 = [@"insert or replace into " stringByAppendingString:tableName];
        NSString *insertSql2 = @" values (?,?)";
        NSString *insertSql = [insertSql1 stringByAppendingString:insertSql2];
        sqlite3_stmt *statement;
        
        if(sqlite3_prepare_v2(db, [insertSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            
            sqlite3_bind_text(statement, 1, [model.createDateTime UTF8String],-1 , NULL);
            sqlite3_bind_text(statement, 2, [model.data UTF8String], -1, NULL);
            
            if(sqlite3_step(statement) != SQLITE_DONE) {
                char *error = "";
                NSAssert1(NO, @"insert fail:%s",error);
            }
        }
        
        sqlite3_finalize(statement);
        [self closeDatabase];
    }
    
    return 1;
}

-(NSMutableArray *)findNewDate:(NSString *)tableName{
    NSMutableArray *listData = [[NSMutableArray alloc] init];
    NSString *filePath = [self applicationDocumentsDirectoryPath];
    
    if(sqlite3_open([filePath UTF8String], &db) != SQLITE_OK){
        NSAssert(NO, @"数据库打开失败");
        [self closeDatabase];
    }
    else{
        //select * from xx order by createDate desc limit 0,9;
        NSString *selectSql1 = [@"select * from "stringByAppendingString:tableName];
        NSString *selectSql2 = @" order by createDate desc limit 0,7";
        NSString *selectSql = [selectSql1 stringByAppendingString:selectSql2];
        sqlite3_stmt *statement;
        
        if(sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                char *createDateTime = (char *)sqlite3_column_text(statement, 0);
                NSString *nsCreateDateTime = [[NSString alloc] initWithUTF8String:createDateTime];
                
                NSString *data = [NSString stringWithFormat:@"%d",sqlite3_column_int(statement, 2)];
                
                ECGDatas *aData = [[ECGDatas alloc] init];
                aData.createDateTime = nsCreateDateTime;
                aData.data = data;
                
                [listData addObject:aData];
            }
        }
        
        sqlite3_finalize(statement);
        [self closeDatabase];
    }
    
    return listData;
}

-(int)createTable:(NSString *)tableName{
    NSString *filePath = [self applicationDocumentsDirectoryPath];
    
    if(sqlite3_open([filePath UTF8String], &db) != SQLITE_OK){
        NSAssert(NO, @"数据库打开失败");
        [self closeDatabase];
        return 0;
    }
    else{
        NSString *createSql1 = [@"create table if not exists " stringByAppendingString:tableName];
        NSString *createSql2 = @" (createDate DATE PRIMARY KEY,data integer)";
        NSString *createSql = [createSql1 stringByAppendingString:createSql2];
        char *error;
        
        if(sqlite3_exec(db, [createSql UTF8String], NULL, NULL, &error) != SQLITE_OK) {
            NSAssert1(NO, @"create %s fail",error);
        }
        
        [self closeDatabase];
    }
    
    return 1;
}

-(void)deleteTable:(NSString *)tableName{
    NSString *filePath = [self applicationDocumentsDirectoryPath];
    
    if(sqlite3_open([filePath UTF8String], &db) != SQLITE_OK){
        NSAssert(NO, @"数据库打开失败");
        [self closeDatabase];
    }
    else{
        NSString *deleteTableSql1 = [@"DROP TABLE " stringByAppendingString:tableName];
        
        char *error;
        
        if(sqlite3_exec(db, [deleteTableSql1 UTF8String], NULL, NULL, &error) != SQLITE_OK) {
            NSAssert1(NO, @"create fail:%s",error);
        }
        
        [self closeDatabase];
    }
}

+(ECGDatasDAO *)sharedManager{
    @synchronized(self) {
        if (manager == nil){
            manager = [[self alloc] init];
            [manager createEditableCopyOfDatabaseIfNeeded];
        }
    }
    
    return manager;
}

-(void)createEditableCopyOfDatabaseIfNeeded{
    NSString *fileName = [self applicationDocumentsDirectoryPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    BOOL dbExits = [fileManager fileExistsAtPath:fileName];
    
    if(!dbExits){
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:DBFILE_NAME];
        dbExits = [fileManager copyItemAtPath:defaultDBPath toPath:fileName error:&error];
        
        if(!dbExits){
            NSAssert1(0, @"Fail to create database file:'%@'.", [error localizedDescription]);
        }
    }
}

-(void)closeDatabase{
    if(sqlite3_close(db) != SQLITE_OK){
        NSAssert1(0, @"Error:failed to close database:'%s'.", sqlite3_errmsg(db));
    }
    
    sqlite3_close(db);
}

-(NSString*)applicationDocumentsDirectoryPath{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [documentDirectory stringByAppendingPathComponent:DBFILE_NAME];
}

@end
