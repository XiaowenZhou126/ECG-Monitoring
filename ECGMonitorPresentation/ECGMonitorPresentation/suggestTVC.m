//
//  suggestTVC.m
//  ECGMonitorPresentation
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "suggestTVC.h"

#define showText @"窦性心动过缓:1. 明显而持久的窦性心动过缓（心率＜50次／min，且不易用阿托品等药物纠正）；2. 多发的窦性静止或严重的窦房阻滞。3. 明显的窦性心动过速而常出现室上性快速心律失常发作，故亦称心动过缓－过速综合征。\n心房颤动:1. 明显而持久的窦性心动过缓（心率＜50次／min，且不易用阿托品等药物纠正）；2. 多发的窦性静止或严重的窦房阻滞。3. 明显的窦性心动过速而常出现室上性快速心律失常发作，故亦称心动过缓－过速综合征。\n窦性心动过速:1. 明显而持久的窦性心动过缓（心率＜50次／min，且不易用阿托品等药物纠正）；2. 多发的窦性静止或严重的窦房阻滞。3. 明显的窦性心动过速而常出现室上性快速心律失常发作，故亦称心动过缓－过速综合征。\n室性早搏:1. 提早出现的QRS－T波群增宽变形，QRS时限常＞0.12sec，T波方向多与主波相反。2. 有完全性代偿间歇（早搏前后两个窦性PP波之间的间隔等于正常P－P间隔的二倍）；3. 提早出现的QRS波前无P波，而窦性P波可巧合于早搏波的任意位置上。\n心房扑动:无正常P波，代之连续的粗齿状F波。F波间无等电位线，波幅大小一致，间隔规则；"
@interface suggestTVC ()
{
    NSAttributedString *attrText;
}
@end

@implementation suggestTVC
@synthesize scrollView,label;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.navigationItem.title = @"Suggest";
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    CGFloat scrollW = 300;
    CGFloat scrollH = 500;
    
    scrollView = [[UIScrollView alloc] init];
    scrollView.frame = CGRectMake((width-scrollW)/2, (height-scrollH)/6, scrollW, scrollH); // frame中的size指UIScrollView的可视范围
    [self.view addSubview:scrollView];
    
    // 显示竖直滚动条
    scrollView.showsVerticalScrollIndicator = YES;
    //    scrollView.showsHorizontalScrollIndicator = NO;//显示水平滚动条
    //scrollView.scrollEnabled =YES;//控制是否可以滚动
    
    UIImage *img = [UIImage imageNamed:@"c5"];
    UIImageView *imgV1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, scrollView.frame.size.width, img.size.height-20)];
    imgV1.image = img;
    imgV1.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:imgV1];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(8, imgV1.frame.size.height, scrollView.frame.size.width-16, scrollView.frame.size.height-40)];
    label.font = [UIFont fontWithName:@"Arial" size:14.0];
    label.textAlignment = NSTextAlignmentLeft;
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.numberOfLines = 0;//设置的行数为不限数量
    CGFloat h = [self getHeight:label.frame.size.width title:showText font:label.font];
    label.frame = CGRectMake(8, 5+imgV1.frame.size.height, scrollView.frame.size.width-16, h);
    label.attributedText = attrText;
    [scrollView addSubview:label];
    
    // 设置UIScrollView的滚动范围（内容大小）
    scrollView.contentSize = CGSizeMake(0, imgV1.frame.size.height+label.frame.size.height+5);
}

//Label自适应，即Label的高度随着内容的变化而变化
-(CGFloat)getHeight:(CGFloat)width title:(NSString *)title font:(UIFont *)font
{
    
    //-----------------首行缩进----------------------
    UILabel *labelTemp = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    NSMutableParagraphStyle *paraStyle01 = [[NSMutableParagraphStyle alloc] init];
    paraStyle01.alignment = NSTextAlignmentLeft;  //对齐
    paraStyle01.headIndent = 0.0f;//行首缩进
    CGFloat emptylen = labelTemp.font.pointSize * 1.5;//参数：（字体大小17号字乘以2，34f即首行空出两个字符）
    paraStyle01.firstLineHeadIndent = emptylen;//首行缩进
    paraStyle01.tailIndent = 0.0f;//行尾缩进
    paraStyle01.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle01.hyphenationFactor = 1.0;
    paraStyle01.paragraphSpacingBefore = 0.0;
    paraStyle01.lineSpacing = 2.0f;//行间距
    NSString *showTextStr  =  title;
    attrText = [[NSAttributedString alloc] initWithString:showTextStr attributes:@{NSParagraphStyleAttributeName:paraStyle01}];
    labelTemp.attributedText = attrText;

    labelTemp.font = font;
    labelTemp.numberOfLines = 0;
    
    //使用sizeToFit和sizeThatFits这两个方法之前，必须要给uilabel赋值，否则不会显示内容的。
    [labelTemp sizeToFit];
    
    return labelTemp.frame.size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}
*/

/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
