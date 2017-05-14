//
//  PersionInfo.h
//  PersistenceLayer
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersionInfo : NSObject

@property(nonatomic) int persionInfoId;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *sex;
@property(nonatomic,strong) NSDate *date_of_birth;
@property(nonatomic,strong) NSString *age;

@end
