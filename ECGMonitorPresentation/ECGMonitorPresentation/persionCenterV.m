//
//  persionCenterV.m
//  ECGMonitorPresentation
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "persionCenterV.h"

@implementation persionCenterV
@synthesize selectedBoy,unselectedBoy,selectedGirl,unselectedGirl;
@synthesize nameTextField;
@synthesize dropDown;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clearsContextBeforeDrawing = YES;
        self.lindWidth = 1.0;
        self.textColor = [UIColor blackColor];
        self.textFont = [UIFont fontWithName:@"Arial" size:18.0];
        
        [self drawListView];
    }
    
    return self;
}

- (void)drawListView{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height/2;
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width/3-10, height/3-10)];
    nameLabel.text = @"姓  名：";
    nameLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:nameLabel];
    
    UILabel *sexLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height/3+5, width/3-10, height/3-10)];
    sexLabel.text = @"性  别：";
    sexLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:sexLabel];
    
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, height/3*2+10, width/3-10, height/3-10)];
    ageLabel.text = @"年  龄：";
    ageLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:ageLabel];
    
    //文本框，用来输入姓名
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(width/3, 10, width/3*2-10, height/3-30)];
    nameTextField.placeholder = @"例如：李四";
    nameTextField.textAlignment = NSTextAlignmentLeft;
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self addSubview:nameTextField];
    
    //单选按钮selectedBoy（男选中时）、unselectedBoy（男没选中时）、selectedGirl（女选中时）、unselectedGirl（女没选中时）
    self.flagBoy = 1;
    selectedBoy = [[UIImageView alloc] initWithFrame:CGRectMake(width/3, height/3+5+(height/3-10)/2-10, 20, 21)];
    [selectedBoy setImage:[UIImage imageNamed:@"selectedRadio"]];
    selectedBoy.userInteractionEnabled = YES;//userInteractionEnabled = NO,当前视图不可交互，该视图上面的子视图也不可与用户交互（不可响应即被该视图忽视），响应事件传递到下面的父视图。
    UITapGestureRecognizer *singleTap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedBoy)];
    [self addSubview:selectedBoy];
    unselectedBoy = [[UIImageView alloc] initWithFrame:CGRectMake(width/3, height/3+5+(height/3-10)/2-10, 20, 21)];
    [unselectedBoy setImage:[UIImage imageNamed:@"unselectedRadio"]];
    [unselectedBoy addGestureRecognizer:singleTap1];
    unselectedBoy.userInteractionEnabled = NO;
    unselectedBoy.hidden = 1;
    [self addSubview:unselectedBoy];
    
    self.flagGirl = 0;
    selectedGirl = [[UIImageView alloc] initWithFrame:CGRectMake(width/3+60, height/3+5+(height/3-10)/2-10, 20, 21)];
    [selectedGirl setImage:[UIImage imageNamed:@"selectedRadio"]];
    selectedGirl.userInteractionEnabled = NO;
    selectedGirl.hidden = 1;
    UITapGestureRecognizer *singleTap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedGirl)];
    [self addSubview:selectedGirl];
    unselectedGirl = [[UIImageView alloc] initWithFrame:CGRectMake(width/3+60, height/3+5+(height/3-10)/2-10, 20, 21)];
    [unselectedGirl setImage:[UIImage imageNamed:@"unselectedRadio"]];
    [unselectedGirl addGestureRecognizer:singleTap2];
    unselectedGirl.userInteractionEnabled = YES;
    [self addSubview:unselectedGirl];

    //boyBtn是点击“男”时，选中“男”按钮；girlBtn是点击“女”时，选中“女”按钮
    UIButton *boyBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/3+20, height/3+5+(height/3-10)/2-(height/3-30)/2, 35, height/3-30)];
    UITapGestureRecognizer *singleTap3 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedBoy)];
    [boyBtn setTitle:@"男" forState:UIControlStateNormal];
    [boyBtn addGestureRecognizer:singleTap3];
    boyBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [boyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:boyBtn];
    
    UIButton *girlBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/3+80, height/3+5+(height/3-10)/2-(height/3-30)/2, 35, height/3-30)];
    UITapGestureRecognizer *singleTap4 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedGirl)];
    [girlBtn setTitle:@"女" forState:UIControlStateNormal];
    [girlBtn addGestureRecognizer:singleTap4];
    girlBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [girlBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self addSubview:girlBtn];
    
    //下拉框
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"新生儿",@"1岁以下",@"2-3岁之间",@"4-6岁之间",@"7-59岁之间",@"60岁以上", nil];
    dropDown = [[DShowlist2 alloc] initWithFrame:CGRectMake(width/3, height/3*2+20+5, width/3*2-10, height/3-30-10)];
    [dropDown createListArray:arr];
    [self addSubview:dropDown];
}

-(void)clickedBoy{
    //点击按钮，图片改变
    self.flagBoy = 1;
    self.flagGirl = 0;
    
    selectedBoy.userInteractionEnabled = YES;
    selectedBoy.hidden = 0;
    unselectedBoy.userInteractionEnabled = NO;
    unselectedBoy.hidden = 1;
    
    selectedGirl.userInteractionEnabled = NO;
    selectedGirl.hidden = 1;
    unselectedGirl.userInteractionEnabled = YES;
    unselectedGirl.hidden = 0;
}

-(void)clickedGirl{
    self.flagBoy = 0;
    self.flagGirl = 1;
    
    selectedBoy.userInteractionEnabled = NO;
    selectedBoy.hidden = 1;
    unselectedBoy.userInteractionEnabled = YES;
    unselectedBoy.hidden = 0;
    
    selectedGirl.userInteractionEnabled = YES;
    selectedGirl.hidden = 0;
    unselectedGirl.userInteractionEnabled = NO;
    unselectedGirl.hidden = 1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
