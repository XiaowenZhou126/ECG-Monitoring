//
//  ECGDatasBL.h
//  BusinessLogicLayer
//
//  Created by mac on 2017/5/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "ECGDatas.h"
#import "ECGDatasDAO.h"

@interface ECGDatasBL : NSObject

@property (nonatomic,strong) ECGDatasDAO *ecgd;
@property (nonatomic,strong) ECGDatas *model;

-(NSString *)getCurDate;
-(void)insertData:(NSMutableArray *)ecgDates;
-(NSMutableArray *)findData;

@end
