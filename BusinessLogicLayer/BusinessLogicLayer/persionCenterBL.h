//
//  persionCenterBL.h
//  BusinessLogicLayer
//
//  Created by mac on 2017/5/16.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PersionInfo.h"
#import "PersionInfoDAO.h"

@interface persionCenterBL : NSObject

@property (nonatomic,strong) PersionInfoDAO *pd;

-(void)findInfo;

@end
