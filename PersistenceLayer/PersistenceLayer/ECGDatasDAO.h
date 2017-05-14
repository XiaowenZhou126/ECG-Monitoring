//
//  ECGDatasDAO.h
//  PersistenceLayer
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ECGDatas.h"

#define DBFILE_NAME @"ECG_Monitor_DB.db"
@interface ECGDatasDAO : NSObject
{
    sqlite3 *db;//保存对数据库的引用
}

+(ECGDatasDAO *)sharedManager;
-(void)createEditableCopyOfDatabaseIfNeeded;
-(NSString *)applicationDocumentsDirectoryPath;//返回文件路径
-(void)closeDatabase;
-(int)createTable:(NSString *)tableName;//不存在添加一张表
-(int)insertData:(ECGDatas *)model andtableName:(NSString*)tableName;//插入一条数据
-(NSMutableArray *)findNewDate:(NSString *)tableName;
-(void)deleteTable:(NSString*)tableName;
@end
