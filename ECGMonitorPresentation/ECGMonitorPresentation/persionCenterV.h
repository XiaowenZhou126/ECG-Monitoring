//
//  persionCenterV.h
//  ECGMonitorPresentation
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DShowlist2.h"
#import "PersionInfo.h"
#import "persionCenterBL.h"

@interface persionCenterV : UIView <persionCenterBLDelegate>
{
    NSDateFormatter *dateFormatter;
    UILabel *errorLable;
    CGFloat width;
    CGFloat height;
}

//下拉框的线宽
@property (nonatomic, assign) CGFloat lindWidth;
//输入文本框字体的颜色
@property (nonatomic, strong) UIColor *textColor;
//输入文本框字体的大小
@property (nonatomic, strong) UIFont *textFont;

@property (nonatomic,strong) UITextField *nameTextField;

@property (nonatomic,strong) UIImageView *selectedBoy;
@property (nonatomic,strong) UIImageView *unselectedBoy;
@property (nonatomic,strong) UIImageView *selectedGirl;
@property (nonatomic,strong) UIImageView *unselectedGirl;

//flagBoy代表男单选按钮，flagGirl代表女单选按钮，当flagBoy=1且flagGirl=0，代表男按钮被选中，当flagBoy=0且flagGirl=1，代表女按钮被选中
@property (nonatomic,assign) BOOL flagSex;

@property (nonatomic,strong) DShowlist2 *dropDown;

@property (nonatomic,strong) persionCenterBL *pbl;

@property (nonatomic,strong) UIButton *boyBtn,*girlBtn;

@property (nonatomic,strong) UITapGestureRecognizer *singleTap1,*singleTap2;

-(void)onChangeBtnClick;
-(BOOL)onSucceedBtnClick;

@end
