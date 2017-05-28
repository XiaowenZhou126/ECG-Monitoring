//
//  monitorTVC.m
//  ECGMonitorPresentation
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "monitorTVC.h"
#import "monitorV.h"
#import "datasOfECG.h"
#import "ECGDatas.h"
#import "ECGDatasDAO.h"

#define MyDeviceName @"MLT-BT05"
@interface monitorTVC () <CBCentralManagerDelegate, CBPeripheralDelegate>

@end

@implementation monitorTVC

@synthesize resultText;

@synthesize locationManager,curLocation,curLocationStr;
@synthesize ecgDates,ecgdataBl;

@synthesize leads,scrollView;
@synthesize labelRate;
@synthesize buffer, photoView;
int leadCount = 1;//画leadCount个心电图
int sampleRate = 500;
float drawingInterval = 0.3f;
int bufferSecond = 300;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.separatorColor = [UIColor clearColor];
    
    self.navigationItem.title = @"ECG Testing";
    ecgdataBl = [[ECGDatasBL alloc] init];
    ecgDates = [[NSMutableArray alloc] initWithCapacity:50];
    index = 0;
    for(int i=0;i<50;i++){
        [ecgDates insertObject:@"0" atIndex:i];
    }
    
    /*
    float width = [[UIScreen mainScreen] bounds].size.width;
    float height = [[UIScreen mainScreen] bounds].size.height;
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"当前",@"最近",nil];
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(width/4.0f, height/35.0f, width/2.0f, height/25.0f);
    segmentedControl.tintColor = [UIColor redColor];
    segmentedControl.selectedSegmentIndex = 0;
    [segmentedControl addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segmentedControl];
    */
    //UIBarButtonSystemItemCancel
    UIBarButtonItem *leftItem =  [[UIBarButtonItem alloc] initWithTitle:@"当前" style:UIBarButtonItemStylePlain  target:self action:@selector(onClickLeft)];
    leftItem.enabled = NO;
    self.navigationItem.leftBarButtonItem = leftItem;
    
    //target:self 是自己调用自己，修改控件的状态
    UIBarButtonItem *rightItem =  [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"c3"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickShareBtn)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    //    CGFloat height = [[UIScreen mainScreen] bounds].size.height;
    
    UILabel *labelMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, width-20, 30)];
    labelMsg.text = @"25mm/s  10mm/mv";
    labelMsg.font = [UIFont fontWithName:@"Arial" size:15.0];
    labelMsg.textAlignment = NSTextAlignmentRight;
    labelMsg.textColor = [UIColor greenColor];
    [self.view addSubview:labelMsg];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 50, width-20, 300)];
    [self.view addSubview:scrollView];
    
    [self addViews];
    
    NSMutableArray *buf = [[NSMutableArray alloc] init];
    self.buffer = buf;//buffer初始化

    
    /********蓝牙获取数据*******/
    resultText = [[UILabel alloc] initWithFrame:CGRectMake(20, 510, 200, 100)];
    resultText.backgroundColor = [UIColor grayColor];
    [self.view addSubview:resultText];
    self.centralMgr = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

-(void)onClickLeft{
    NSLog(@"left");
    for(int i=0;i<91;i++){
        [self dealDatas:@"1"];
    }
}

/*
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
 */

- (void)onClickShareBtn
{
    NSLog(@"Click Share");

    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"定位服务当前可能尚未打开，请设置打开！");
        return;
    }
    
    locationManager = [[CLLocationManager alloc] init];
    //kCLLocationAccuracyHundredMeters导航精确到100米
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    //如果没有授权则请求用户授权
    if([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]){
        NSLog(@"未授权。。。");
        [locationManager requestAlwaysAuthorization];
    }
    
    locationManager.delegate = self;
    //距离过滤器，定义了设备移动后获得位置的最小距离，单位是米
    locationManager.distanceFilter = 1000.0f;
    
    [locationManager startUpdatingLocation];

}

/*****************************蓝牙****************************************/
//检查App的设备BLE是否可用 （ensure that Bluetooth low energy is supported and available to use on the central device）
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state)
    {
        case CBCentralManagerStatePoweredOn:
            //discover what peripheral devices are available for your app to connect to
            //第一个参数为CBUUID的数组，需要搜索特点服务的蓝牙设备，只要每搜索到一个符合条件的蓝牙设备都会调用didDiscoverPeripheral代理方法
            [self.centralMgr scanForPeripheralsWithServices:nil options:nil];
            break;
        default:
            NSLog(@"Central Manager did change state");
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    //找到需要的蓝牙设备，停止搜素，保存数据
    if([peripheral.name isEqualToString:MyDeviceName]){
        _discoveredPeripheral = peripheral;
        [_centralMgr connectPeripheral:peripheral options:nil];
    }
}

//连接成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    //Before you begin interacting with the peripheral, you should set the peripheral’s delegate to ensure that it receives the appropriate callbacks（设置代理）
    [_discoveredPeripheral setDelegate:self];
    //discover all of the services that a peripheral offers,搜索服务,回调didDiscoverServices
    [_discoveredPeripheral discoverServices:nil];
}

//连接失败，就会得到回调：
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    //此时连接发生错误
    NSLog(@"connected periphheral failed");
}

//获取服务后的回调
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    if (error)
    {
        NSLog(@"didDiscoverServices : %@", [error localizedDescription]);
        return;
    }
    
    for (CBService *s in peripheral.services)
    {
        NSLog(@"Service found with UUID : %@", s.UUID);
        //Discovering all of the characteristics of a service,回调didDiscoverCharacteristicsForService
        [s.peripheral discoverCharacteristics:nil forService:s];
    }
}

//获取特征后的回调
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    if (error)
    {
        NSLog(@"didDiscoverCharacteristicsForService error : %@", [error localizedDescription]);
        return;
    }
    
    for (CBCharacteristic *c in service.characteristics)
    {
        NSLog(@"c.properties:%lu",(unsigned long)c.properties) ;
        //Subscribing to a Characteristic’s Value 订阅
        [peripheral setNotifyValue:YES forCharacteristic:c];
        // read the characteristic’s value，回调didUpdateValueForCharacteristic
        [peripheral readValueForCharacteristic:c];
        _writeCharacteristic = c;
    }
    
}

//订阅的特征值有新的数据时回调
- (void)peripheral:(CBPeripheral *)peripheral
didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@",
              [error localizedDescription]);
    }
    
    [peripheral readValueForCharacteristic:characteristic];
    
}

// 获取到特征的值时回调
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error)
    {
        NSLog(@"didUpdateValueForCharacteristic error : %@", error.localizedDescription);
        return;
    }
    
    NSData *data = characteristic.value;
    NSString *ecgData = [[ NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    resultText.text = ecgData;
    NSLog(@"此时的心电数据：%@",resultText.text);
    
    if(ecgData && ecgData.length>1){
        //存在且是数字
        NSString *tempData = [ecgData substringToIndex:4];
        if([self isPureInt:tempData])
            [self dealDatas:tempData];

    }
    
    
}
/***************************蓝牙end**************************************/

//判断字符串是否是纯数字（整形）
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

-(void)dealDatas:(NSString*)data{
    //过滤数据，当数据的值不为0的时候，才需要处理
    if(![data isEqualToString:@"0"]){
        
        if([[ecgDates lastObject] isEqualToString:@"0"]){
            //数组最后一个元素为0,添加数据，即数组中没有50个有效数据
            [ecgDates replaceObjectAtIndex:index withObject:data];//添加数据
            index++;
        }
        else{
            //判断时间是否一致，一天一个表
            //index = 1,清除ecgDates的数据后，插入当前的数据，所以index=1
        
            [ecgdataBl insertData:ecgDates];

            
            /*----------------------------------------------------------------*/
            /*
            NSMutableArray *intData = [[NSMutableArray alloc] init];
            for(int i=0;i<ecgDates.count;i++){
                NSNumber *temp = @(([ecgDates[i] intValue])/100);
                [intData addObject:temp];
            }
            NSArray *popPoints = [NSArray arrayWithObject:intData];
            monitorV *lead = [self.leads objectAtIndex:0];
           // [lead.pointsArray addObjectsFromArray:popPoints];
             */
             /*----------------------------------------------------------------*/
            
            
            for(int i=0;i<50;i++){
                [ecgDates replaceObjectAtIndex:i withObject:@"0"];
            }
            [ecgDates replaceObjectAtIndex:0 withObject:data];//添加数据
            
            index = 1;
            
        }
    }
}


/***************************定位**************************************/

#pragma mark Core Location 委托方法用于实现位置的更新
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    self.curLocation = [locations lastObject];

    //取消延迟执行函数
    //[[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(reverse) object:nil];
    //[self performSelector:@selector(reverse) withObject:nil afterDelay:0.f];
    
    [self reverse];
}

-(void)reverse{
    CLGeocoder *gl = [[CLGeocoder alloc] init];
    
    
    [gl reverseGeocodeLocation:curLocation completionHandler:^(NSArray *placemarks,NSError *error){
        
        if (error){
            NSLog(@"Geocode failed with error: %@", error);
            return;
        }
        
        if([placemarks count] >0){
            NSLog(@"===================");
            NSInteger count = [placemarks count];
            CLPlacemark *placemark = placemarks[0];
        
        //name西安邮电大学长安校区（东区）country=中国,administrativeArea=陕西省,locality=西安市,subLocality=长安区
            NSString *latitude = [NSString stringWithFormat:@"%f",curLocation.coordinate.latitude];
             NSString *longitude = [NSString stringWithFormat:@"%f",curLocation.coordinate.longitude];
             curLocationStr = [NSString stringWithFormat:@"纬度：%@，经度：%@,地标：%@%@%@%@%@",latitude,longitude,placemark.name,placemark.country,placemark.administrativeArea,placemark.locality,placemark.subLocality];
            
        NSLog(@"%ld,name=%@,country=%@,locality=%@,administrativeArea=%@,subLocality=%@",count,placemark.name,placemark.country,placemark.locality,placemark.administrativeArea,placemark.subLocality);
            
            /*
            UILabel *x = [[UILabel alloc] initWithFrame:CGRectMake(20, 400, 1000, 200)];
            x.text = curLocationStr;
            
            [self.view addSubview:x];
             */
        }
    }];
    
    [locationManager stopUpdatingLocation];
  
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"error:%@",error);
    [locationManager stopUpdatingLocation];
}
/****************-----------定位 end----------****************************/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [self setLeadsLayout];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self startLiveMonitoring];
}

- (void)startLiveMonitoring
{
    //	stopTheTimer = NO;
    
    [self startTimer_popDataFromBuffer];
    [self startTimer_drawing];
}

- (void)startTimer_popDataFromBuffer
{
    CGFloat popDataInterval = 1.0f;//1s写入一次数据
    
    popDataTimer = [NSTimer scheduledTimerWithTimeInterval:popDataInterval
                                                    target:self
                                                  selector:@selector(timerEvent_popData)
                                                  userInfo:NULL
                                                   repeats:YES];
}

- (void)timerEvent_popData
{
    [self popDemoDataAndPushToLeads];
}

- (void)popDemoDataAndPushToLeads
{
    //int length = 440;
    //short **data = [datasOfECG getDemoData:length];
    //NSArray *data12Arrays = [self convertDemoData:data dataLength:length doWilsonConvert:NO];
    
    NSMutableArray *intData = [[NSMutableArray alloc] init];
    for(int i=0;i<ecgDates.count;i++){
        NSNumber *temp = @(([ecgDates[i] intValue])/2);
        [intData addObject:temp];
    }

    
    for (int i=0; i<leadCount; i++)
    {
        //NSArray *data = [data12Arrays objectAtIndex:i];
        
        [self pushPoints:intData data12Index:i];
    }
}

- (void)pushPoints:(NSArray *)_pointsArray data12Index:(NSInteger)data12Index;
{
    monitorV *lead = [self.leads objectAtIndex:data12Index];
    
    if (lead.pointsArray.count > bufferSecond * sampleRate)
    {
        [lead resetBuffer];
    }
    
    if (lead.pointsArray.count - lead.currentPoint <= 2000)
    {
        [lead.pointsArray addObjectsFromArray:_pointsArray];
    }
    
    if (data12Index==0)
    {
        //		countOfPointsInQueue = lead.pointsArray.count;
        currentDrawingPoint = lead.currentPoint;
    }
}

- (NSArray *)convertDemoData:(short **)rawdata dataLength:(int)length doWilsonConvert:(BOOL)wilsonConvert
{
    NSMutableArray *data = [[NSMutableArray alloc] init];
    for (int i=0; i<12; i++)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [data addObject:array];
    }
    
    for (int i=0; i<length; i++)
    {
        for (int j=0; j<12; j++)
        {
            NSMutableArray *array = [data objectAtIndex:j];
            NSNumber *number = [NSNumber numberWithInt:rawdata[i][j]];
            [array insertObject:number atIndex:i];
        }
    }
    
    return data;
}

- (void)timerEvent_drawing
{
    [self drawRealTime];
}

- (void)drawRealTime
{
    monitorV *l = [self.leads objectAtIndex:0];
    
    if (l.pointsArray.count > l.currentPoint)
    {
        for (monitorV *lead in self.leads)
        {
            [lead fireDrawing];
        }
    }
}

- (void)startTimer_drawing
{
    drawingTimer = [NSTimer scheduledTimerWithTimeInterval:drawingInterval
                                                    target:self
                                                  selector:@selector(timerEvent_drawing)
                                                  userInfo:NULL
                                                   repeats:YES];
}

//setLeadsLayout设置Leads Layout
- (void)setLeadsLayout
{
    float margin = 5;
    NSInteger leadHeight = self.scrollView.frame.size.height - margin*2;
    NSInteger leadWidth = self.scrollView.frame.size.width;
    //    scrollView.contentSize = self.scrollView.frame.size;
    /*
     contentSize、contentInset和contentOffset 是 scrollView三个基本的属性。
     contentSize: The size of the content view. 其实就是scrollview可以滚动的区域，比如frame = (0 ,0 ,320 ,480) contentSize = (320 ,960)，代表你的scrollview可以上下滚动，滚动区域为frame大小的两倍。
     contentOffset:The point at which the origin of the content view is offset from the origin of the scroll view. 是scrollview当前显示区域顶点相对于frame顶点的偏移量，比如上个例子你拉到最下面，contentoffset就是(0 ,480)，也就是y偏移了480
     contentInset:The distance that the content view is inset from the enclosing scroll view.是scrollview的contentview的顶点相对于scrollview的位置，例如你的contentInset = (0 ,100)，那么你的contentview就是从scrollview的(0 ,100)开始显示
     */
    
    for (int i=0; i<leadCount; i++)
    {
        monitorV *lead = [self.leads objectAtIndex:i];
        float pos_y = i * (margin + leadHeight)+margin;
        
        [lead setFrame:CGRectMake(0., pos_y, leadWidth, leadHeight)];
        lead.pos_x_offset = lead.currentPoint;
        lead.alpha = 1;
        [lead setNeedsDisplay];
    }
    
    [UIView animateWithDuration:0.6f animations:^{
        for (int i=0; i<leadCount; i++)
        {
            monitorV *lead = [self.leads objectAtIndex:i];
            lead.alpha = 1;
        }
    }];
}

- (void)addViews
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i=0; i<leadCount; i++) {
        monitorV *lead = [[monitorV alloc] init];
        
        lead.layer.cornerRadius = 8;//设置圆角
        lead.layer.borderColor = [[UIColor grayColor] CGColor];
        lead.layer.borderWidth = 3;//border
        lead.clipsToBounds = YES;//当它取值为 YES 时，剪裁超出父视图范围的子视图部分；当它取值为 NO 时，不剪裁子视图。
        
        lead.index = i;//此时正在初始化第i个图形
        lead.pointsArray = [[NSMutableArray alloc] init];
        
        lead.liveMonitor = self;
		      
        [array insertObject:lead atIndex:i];//进栈
        
        [self.scrollView addSubview:lead];//将第i个心电图放入scrollView中
    }
    
    self.leads = array;
}

@end
