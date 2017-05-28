//
//  ECGDatasBL.m
//  BusinessLogicLayer
//
//  Created by mac on 2017/5/28.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ECGDatasBL.h"

@implementation ECGDatasBL
@synthesize ecgd,model;

-(void)insertData:(NSMutableArray *)ecgDates{
    model = [[ECGDatas alloc] init];
    model.createDateTime = [self getCurTime];
    model.data = [ecgDates componentsJoinedByString:@","];
    
    ecgd = [ECGDatasDAO sharedManager];
    NSString *temp = [self getCurDate];
    [ecgd createTable:temp];
    [ecgd insertData:model andtableName:temp];
}

//获取当前时间
-(NSString *)getCurTime{
    //获得系统日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式，以字符串表示的日期形式的格式
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    // 格式化日期，GMT 时间，NSDate 转 NSString
    NSString *currentTimeStr = [formatter stringFromDate:[NSDate date]];
    NSLog(@"当前时间%@",currentTimeStr);
    return currentTimeStr;
}

//获取当前日期
-(NSString *)getCurDate{
    //获得系统日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置日期格式，以字符串表示的日期形式的格式
    [formatter setDateFormat:@"yyyyMMdd"];
    // 格式化日期，GMT 时间，NSDate 转 NSString
    NSString *currentTimeStr = [@"ECG" stringByAppendingString:[formatter stringFromDate:[NSDate date]] ];
    NSLog(@"当前日期%@",currentTimeStr);
    return currentTimeStr;
}

@end
