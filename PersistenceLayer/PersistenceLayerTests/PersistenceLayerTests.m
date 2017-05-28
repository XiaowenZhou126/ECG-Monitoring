//
//  PersistenceLayerTests.m
//  PersistenceLayerTests
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PersistenceLayer.h"
#import "PersionInfoDAO.h"
#import "ECGDatas.h"
#import "ECGDatasDAO.h"

@interface PersistenceLayerTests : XCTestCase
{
    PersistenceLayer *p;
    NSDateFormatter *dateFormatter;
    PersionInfoDAO *pd;
    ECGDatasDAO *ecgd;
}
@end

@implementation PersistenceLayerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    p = [[PersistenceLayer alloc] init];
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    pd = [PersionInfoDAO sharedManager];
    ecgd = [ECGDatasDAO sharedManager];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    p = nil;
    pd = nil;
    ecgd = nil;
}

-(void)testPersionInfo{
    //test : remove
    XCTAssertEqual(1, [pd removeInfo]);
    
    //test : findInfo method
    XCTAssertNil(pd.findInfo);
    
    //test : insertInfo method
    PersionInfo *model1 = [[PersionInfo alloc] init];
    model1.persionInfoId = 1;
    model1.name = @"bob";
    model1.sex = @"男";
    model1.date_of_birth = [dateFormatter dateFromString:@"1992-08-04"];
    model1.age = @"64";
    XCTAssertEqual(1, [pd insertInfo:model1]);
    
    //test : findInfo method
    XCTAssertNotNil(pd.findInfo);
    
    //test : updateInfo method
    PersionInfo *model = [[PersionInfo alloc] init];
    model.persionInfoId = 1;
    model.name = @"bob";
    model.sex = @"男";
    model.date_of_birth = [dateFormatter dateFromString:@"1997-08-04"];
    model.age = @"63";
    XCTAssertEqual(1, [pd updateInfo:model]);
}

-(void)testECGDatas{
    NSString *tableName = @"ECG20160111";
    XCTAssertEqual(1, [ecgd createTable:tableName]);
    
    ECGDatas *model = [[ECGDatas alloc] init];
    model.createDateTime = @"2011-01-16 21:22:12";
    model.data = @"111,222,212,211,112";
    ECGDatas *model1 = [[ECGDatas alloc] init];
    model1.createDateTime = @"2011-01-15 21:21:12";
    model1.data = @"112,222,212,211,112";
    XCTAssertEqual(1, [ecgd insertData:model andtableName:tableName]);
    XCTAssertEqual(1, [ecgd insertData:model1 andtableName:tableName]);
    NSMutableArray *listData = [ecgd findNewDate:tableName];
    XCTAssertNotNil(listData);
    ECGDatas *aData = [listData objectAtIndex:1];
    XCTAssertEqualObjects(@"2011-01-15 21:21:12", aData.createDateTime);
    [ecgd deleteTable:tableName];
}

- (void)testPrint {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqualObjects(@"print PersistenceLayer", p.print);
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
