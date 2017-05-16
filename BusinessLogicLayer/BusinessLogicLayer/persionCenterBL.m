//
//  persionCenterBL.m
//  BusinessLogicLayer
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "persionCenterBL.h"

@implementation persionCenterBL
@synthesize pd,p;

//初始化界面，自动调用该函数
-(void)findPersionInfo{
    pd = [PersionInfoDAO sharedManager];
    p = pd.findInfo;
    if(p!=nil){
        [self.delegate getInfo:p];
    }
}

//点击“完成”，获取数据-》对比-》写入数据库,不需要代理
//对比相同，不修改；不同则，修改
-(void)updatePersionInfo:(PersionInfo *)pTemp{
    if(!([pTemp.name isEqual:p.name] && [pTemp.sex isEqual:p.sex] && [pTemp.age isEqual:p.age])){
    //对象的值不相等，写入数据库
        [pd updateInfo:pTemp];
    }
    else{
        NSLog(@"无需更改");
    }
}

@end
