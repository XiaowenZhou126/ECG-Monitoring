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
@synthesize pbl;
@synthesize boyBtn,girlBtn;


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        width = self.frame.size.width;
        height = self.frame.size.height/2;
        
        self.backgroundColor = [UIColor whiteColor];
        self.clearsContextBeforeDrawing = YES;
        self.lindWidth = 1.0;
        self.textColor = [UIColor blackColor];
        self.textFont = [UIFont fontWithName:@"Arial" size:18.0];
        
        self.singleTap1 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedBoy)];
        self.singleTap2 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedGirl)];
        
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        errorLable = [[UILabel alloc] initWithFrame:CGRectMake(width/3, height/3-20, width-width/3-10, 10)];
        errorLable.textColor = [UIColor redColor];
        errorLable.text = @"姓名不能为空";
        errorLable.font = [UIFont fontWithName:@"Arial" size:10.0];
        errorLable.hidden = 1;
        [self addSubview:errorLable];
        
        [self drawListView];
    }
    
    return self;
}

- (void)drawListView{
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
    nameTextField = [[UITextField alloc] initWithFrame:CGRectMake(width/3, 15, width-width/3-10, height/3-40)];
    nameTextField.placeholder = @"例如：李四";
    nameTextField.textAlignment = NSTextAlignmentLeft;
    nameTextField.font = [UIFont fontWithName:@"Arial" size:13.0];
    nameTextField.borderStyle = UITextBorderStyleRoundedRect;
    nameTextField.enabled = NO;
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:nameTextField];
    
    self.flagSex = 1;//flagSex=1，选中“男”；flagSex=0，选中“女”；
    
    //单选按钮selectedBoy（男选中时）、unselectedBoy（男没选中时）、selectedGirl（女选中时）、unselectedGirl（女没选中时）
    selectedBoy = [[UIImageView alloc] initWithFrame:CGRectMake(width/3, height/3+5+(height/3-10)/2-10, 20, 21)];
    [selectedBoy setImage:[UIImage imageNamed:@"selectedRadio"]];
//    selectedBoy.userInteractionEnabled = YES;//userInteractionEnabled = NO,当前视图不可交互，该视图上面的子视图也不可与用户交互（不可响应即被该视图忽视），响应事件传递到下面的父视图。=================
    [self addSubview:selectedBoy];
    unselectedBoy = [[UIImageView alloc] initWithFrame:CGRectMake(width/3, height/3+5+(height/3-10)/2-10, 20, 21)];
    [unselectedBoy setImage:[UIImage imageNamed:@"unselectedRadio"]];
    unselectedBoy.hidden = 1;
    [self addSubview:unselectedBoy];
    
    selectedGirl = [[UIImageView alloc] initWithFrame:CGRectMake(width/3+60, height/3+5+(height/3-10)/2-10, 20, 21)];
    [selectedGirl setImage:[UIImage imageNamed:@"selectedRadio"]];
    selectedGirl.hidden = 1;
    [self addSubview:selectedGirl];
    unselectedGirl = [[UIImageView alloc] initWithFrame:CGRectMake(width/3+60, height/3+5+(height/3-10)/2-10, 20, 21)];
    [unselectedGirl setImage:[UIImage imageNamed:@"unselectedRadio"]];
    [self addSubview:unselectedGirl];

    //boyBtn是点击“男”时，选中“男”按钮；girlBtn是点击“女”时，选中“女”按钮
    boyBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/3+20, height/3+5+(height/3-10)/2-(height/3-30)/2, 35, height/3-30)];
    UITapGestureRecognizer *singleTap3 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedBoy)];
    [boyBtn setTitle:@"男" forState:UIControlStateNormal];
    [boyBtn addGestureRecognizer:singleTap3];
    boyBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [boyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [boyBtn setUserInteractionEnabled:NO];//非编辑状态不能点击====
    [self addSubview:boyBtn];
    
    girlBtn = [[UIButton alloc] initWithFrame:CGRectMake(width/3+80, height/3+5+(height/3-10)/2-(height/3-30)/2, 35, height/3-30)];
    UITapGestureRecognizer *singleTap4 =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedGirl)];
    [girlBtn setTitle:@"女" forState:UIControlStateNormal];
    [girlBtn addGestureRecognizer:singleTap4];
    girlBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [girlBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [girlBtn setUserInteractionEnabled:NO];//非编辑状态不能点击=====
    [self addSubview:girlBtn];
    
    //下拉框
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"新生儿",@"1岁以下",@"2-3岁之间",@"4-6岁之间",@"7-59岁之间",@"60岁以上", nil];
    dropDown = [[DShowlist2 alloc] initWithFrame:CGRectMake(width/3, height/3*2+20+5, width/3*2-10, height/3-30-10)];
    [dropDown createListArray:arr];
    [self addSubview:dropDown];
    
    pbl = [[persionCenterBL alloc] init];
    pbl.delegate = self;
    [pbl findPersionInfo];
}

-(void)clickedBoy{
    //点击按钮，图片改变
    self.flagSex = 1;
    
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
    self.flagSex = 0;
    
    selectedBoy.userInteractionEnabled = NO;
    selectedBoy.hidden = 1;
    unselectedBoy.userInteractionEnabled = YES;
    unselectedBoy.hidden = 0;
    
    selectedGirl.userInteractionEnabled = YES;
    selectedGirl.hidden = 0;
    unselectedGirl.userInteractionEnabled = NO;
    unselectedGirl.hidden = 1;
}

//点击“修改信息文本框”，使得Persion Center界面部分控件（nameTextField，unselectedBoy，unselectedGirl，boyBtn，girlBtn，dropDown）可编辑
-(void)onChangeBtnClick{
    nameTextField.enabled = YES;
    [unselectedBoy addGestureRecognizer:self.singleTap1];
    [unselectedGirl addGestureRecognizer:self.singleTap2];
    [boyBtn setUserInteractionEnabled:YES];
    [girlBtn setUserInteractionEnabled:YES];
    [dropDown changeStatus];
}

-(BOOL)onSucceedBtnClick{
    NSLog(@"come on");
    
    if(![nameTextField.text isEqual:@""]){
        nameTextField.enabled = NO;
        [unselectedBoy removeGestureRecognizer:self.singleTap1];
        [unselectedGirl removeGestureRecognizer:self.singleTap2];
        [boyBtn setUserInteractionEnabled:NO];
        [girlBtn setUserInteractionEnabled:NO];
        [dropDown succeedStatus];

        PersionInfo *ptemp = [[PersionInfo alloc] init];
        ptemp.persionInfoId = 1;
        ptemp.name = nameTextField.text;
        ptemp.sex = self.flagSex == 1 ? @"男" : @"女";
        ptemp.age = dropDown.getBtnTitle;
        NSLog(@"%@,%@,%@,%@",ptemp.name,ptemp.sex,ptemp.age,ptemp.date_of_birth);
        //    [pbl updatePersionInfo:ptemp];
        return 1;
    }
    else{
        //nameTextField.text为空，
        [nameTextField becomeFirstResponder];
        errorLable.hidden = 0;//errorLable是nameTextField为空时，才显示错误
        
        //UIView *rightVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, nameTextField.frame.size.height)];
        //rightVeiw.backgroundColor = [UIColor grayColor];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, nameTextField.frame.size.height)];
        imageView.image = [UIImage imageNamed:@"error"];//[[UIImage alloc] initWithImage:[UIImage imageNamed:@"error"]];
        imageView.contentMode =  UIViewContentModeCenter;
        
        //[rightVeiw addSubview:imageView];
        
        //nameTextField.rightView = rightVeiw;
        
        nameTextField.rightView = imageView;
        nameTextField.rightViewMode = UITextFieldViewModeWhileEditing;
        
        //将nameField监视，当其内容发生变化时，调用textFieldDidChange
        [nameTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventAllEditingEvents];
        return 0;
    }
}

//监视nameTextField内容的变化，当内容发生变化时，调用此方法
- (void) textFieldDidChange:(id) sender {
    errorLable.hidden = 1;//nameTextField内容改变（这里是nameTextField不为空时）errorLable显示

    nameTextField.rightView = UITextFieldViewModeNever;
    nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)getInfo:(PersionInfo *)info{
    if(info!=nil){
        nameTextField.text = info.name;
        if([info.sex isEqual:@"男"]){
            [self clickedBoy];
        }
        else{
            [self clickedGirl];
        }
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:@"新生儿",@"1岁以下",@"2-3岁之间",@"4-6岁之间",@"7-59岁之间",@"60岁以上",nil];
        NSUInteger index = [arr indexOfObject:info.age];
        if(index == NSNotFound){
            //没有找到
            NSLog(@"Not Found");
        }else{
            //找到了
            [dropDown getRow:index];
        }
        
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
