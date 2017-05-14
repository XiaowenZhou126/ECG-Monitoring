//
//  PersionInfoDAO.m
//  PersistenceLayer
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "PersionInfoDAO.h"

@implementation PersionInfoDAO

static PersionInfoDAO *manager = nil;

-(int)removeInfo{
    NSString *filePath = [self applicationDocumentsDirectoryPath];
    
    if(sqlite3_open([filePath UTF8String], &db) != SQLITE_OK){
        NSAssert(NO, @"数据库打开失败");
        [self closeDatabase];
        return 0;
    }
    else{
        NSString *removeSql = @"delete from persionInfo";
        char *error;
        if(sqlite3_exec(db, [removeSql UTF8String], NULL, NULL, &error) != SQLITE_OK){
            NSAssert1(NO, @"remove fail:'%s'",error);
        }
        [self closeDatabase];
    }
    
    return 1;
}

-(int)insertInfo:(PersionInfo *)model{
    NSString *filePath = [self applicationDocumentsDirectoryPath];
    
    if(sqlite3_open([filePath UTF8String], &db) != SQLITE_OK){
        NSAssert(NO, @"数据库打开失败");
        [self closeDatabase];
        return 0;
    }
    else{
        NSString *insertSql = @"insert or replace into persionInfo (id,name,sex,date_of_birth,age) values (1,?,?,?,?)";
        sqlite3_stmt *statement;
        
        if(sqlite3_prepare_v2(db, [insertSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            
            NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
            [dataFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *nsdate_of_birth = [dataFormatter stringFromDate:model.date_of_birth];
            
            sqlite3_bind_text(statement, 1, [model.name UTF8String],-1 , NULL);
            sqlite3_bind_text(statement, 2, [model.sex UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [nsdate_of_birth UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 4, [model.age UTF8String], -1, NULL);
            
            if(sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"insert fail");
            }
        }
        
        sqlite3_finalize(statement);
        [self closeDatabase];
    }
    
    return 1;
}

-(int)updateInfo:(PersionInfo *)model{
    NSString *filePath = [self applicationDocumentsDirectoryPath];
    
    if(sqlite3_open([filePath UTF8String], &db) != SQLITE_OK){
        NSAssert(NO, @"数据库打开失败");
        [self closeDatabase];
        return 0;
    }
    else{
        NSString *updateSql = @"update persionInfo set name=?,sex=?,date_of_birth=?,age=? where id=1";
        sqlite3_stmt *statement;
        
        if(sqlite3_prepare_v2(db, [updateSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            
            NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
            [dataFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *nsdate_of_birth = [dataFormatter stringFromDate:model.date_of_birth];
            
            sqlite3_bind_text(statement, 1, [model.name UTF8String],-1 , NULL);
            sqlite3_bind_text(statement, 2, [model.sex UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 3, [nsdate_of_birth UTF8String], -1, NULL);
            sqlite3_bind_text(statement, 4, [model.age UTF8String], -1, NULL);
            
            if(sqlite3_step(statement) != SQLITE_DONE) {
                NSAssert(NO, @"update fail");
            }
        }
        
        sqlite3_finalize(statement);
        [self closeDatabase];
    }
    return 1;
}

-(PersionInfo *)findInfo{
    NSString *filePath = [self applicationDocumentsDirectoryPath];
    PersionInfo *pInfo = nil;
    
    if(sqlite3_open([filePath UTF8String], &db) != SQLITE_OK){
        NSAssert(NO, @"数据库打开失败");
        [self closeDatabase];
    }
    else{
        NSString *selectSql = @"select * from persionInfo";
        sqlite3_stmt *statement;
        
        if(sqlite3_prepare_v2(db, [selectSql UTF8String], -1, &statement, NULL) == SQLITE_OK){
            NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
            [dataFormatter setDateFormat:@"yyyy-MM-dd"];
            
            if(sqlite3_step(statement) == SQLITE_ROW) {
                char *name = (char *)sqlite3_column_text(statement, 1);
                NSString *nsname = [[NSString alloc] initWithUTF8String:name];
                char *sex = (char *)sqlite3_column_text(statement, 2);
                NSString *nssex = [[NSString alloc] initWithUTF8String:sex];
                
                char *date_of_birth = (char *)sqlite3_column_text(statement, 3);
                NSString *nsdate_of_birth = [[NSString alloc] initWithUTF8String:date_of_birth];
                
                char *age = (char *)sqlite3_column_text(statement, 4);
                NSString *nsage = [[NSString alloc] initWithUTF8String:age];
                
                pInfo =[[PersionInfo alloc] init];
                pInfo.persionInfoId = sqlite3_column_int(statement, 0);
                pInfo.name = nsname;
                pInfo.sex = nssex;
                pInfo.date_of_birth = [dataFormatter dateFromString:nsdate_of_birth];
                pInfo.age = nsage;
            }
        }
        
        sqlite3_finalize(statement);
        [self closeDatabase];
    }
    
    return pInfo;
}

+(PersionInfoDAO *)sharedManager{
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
        NSLog(@"defaultDB:%@",defaultDBPath);
        dbExits = [fileManager copyItemAtPath:defaultDBPath toPath:fileName error:&error];
        
        if(!dbExits){
            NSAssert1(0, @"Fail to create database file:'%@'.", [error localizedDescription]);
        }
    }
}

-(void)closeDatabase{
    if(sqlite3_close(db) != SQLITE_OK){
        NSAssert1(0, @"Error:failed to close database:'%s'.",         sqlite3_errmsg(db));
    }
    
    sqlite3_close(db);
}

-(NSString*)applicationDocumentsDirectoryPath{
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    return [documentDirectory stringByAppendingPathComponent:DBFILE_NAME];
}

@end
