//
//  persionCenterTVC.m
//  ECGMonitorPresentation
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "persionCenterTVC.h"

@interface persionCenterTVC ()

@end

@implementation persionCenterTVC
@synthesize pcv;

int marginLeft = 40;
int marginTop = 30;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.navigationItem.title = @"Persion Center";
    [self changeInfo];
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
   
    pcv = [[persionCenterV alloc] initWithFrame:CGRectMake(width/2-120, marginTop, 240, height/3*2)];
    pcv.backgroundColor = [UIColor clearColor];
//    pcv.layer.borderWidth = 1;
    [self.view addSubview:pcv];
}

-(void)changeInfo{
    //target:self 是自己调用自己，修改控件的状态
    UIBarButtonItem *rightItem =  [[UIBarButtonItem alloc] initWithTitle:@"修改信息" style:UIBarButtonItemStylePlain target:self action:@selector(onChangeButton)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)onChangeButton{
    UIBarButtonItem *rightItem =  [[UIBarButtonItem alloc] initWithTitle:@"完  成" style:UIBarButtonItemStylePlain target:self action:@selector(changeSucceed)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [pcv onChangeBtnClick];
}

-(void)changeSucceed{
    if([pcv onSucceedBtnClick]){
      [self changeInfo];   
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
