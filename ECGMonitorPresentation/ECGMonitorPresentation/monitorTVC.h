//
//  monitorTVC.h
//  ECGMonitorPresentation
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <AddressBook/AddressBook.h>

@interface monitorTVC : UITableViewController <CLLocationManagerDelegate>
{
    NSMutableArray *leads, *buffer;//leads存放多少个心电图
    NSTimer *drawingTimer, *popDataTimer;
    
    UILabel *labelRate;
    //	int countOfPointsInQueue;
    int currentDrawingPoint;
}

@property (nonatomic, strong) NSMutableArray *leads, *buffer;
@property (nonatomic, strong) IBOutlet UIButton *photoView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UILabel *labelRate;

@property (nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic,strong) CLLocation *curLocation;

@end
