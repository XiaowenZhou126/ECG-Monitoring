//
//  monitorTVC.m
//  ECGMonitorPresentation
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "monitorTVC.h"

@interface monitorTVC ()

@end

@implementation monitorTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.navigationItem.title = @"ECG Testing";
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"当前",@"最近",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(width/4.0f, height/35.0f, width/2.0f, height/25.0f);
    segmentedControl.tintColor = [UIColor redColor];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    
    UIButton *shareBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(width/6*5, height/50.0f, 50, 50);//注意设置为图片大小，不然会出现模糊
    shareBtn.backgroundColor = [UIColor grayColor];
    [shareBtn setImage:[UIImage imageNamed:@"c3"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(onClickShareBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
}

-(void)change:(UISegmentedControl *)sender{
    NSLog(@"测试");
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"1");
        self.view.backgroundColor = [UIColor greenColor];
    }else if (sender.selectedSegmentIndex == 1){
        NSLog(@"2");
        self.view.backgroundColor = [UIColor yellowColor];
    }
}

- (void)onClickShareBtn
{
    NSLog(@"Click Share");
    self.view.backgroundColor = [UIColor purpleColor];
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
