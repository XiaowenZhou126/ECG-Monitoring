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
#import <sqlite3.h>

@protocol persionCenterBLDelegate <NSObject>
@required
- (void)getInfo:(PersionInfo *)info;
@end

@interface persionCenterBL : NSObject

@property (nonatomic, weak) id <persionCenterBLDelegate> delegate;
@property (nonatomic,strong) PersionInfoDAO *pd;
@property (nonatomic,strong) PersionInfo *p;

-(void)findPersionInfo;
-(void)updatePersionInfo:(PersionInfo *)p;

@end
