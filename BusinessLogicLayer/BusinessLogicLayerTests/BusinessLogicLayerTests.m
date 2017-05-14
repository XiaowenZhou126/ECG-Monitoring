//
//  BusinessLogicLayerTests.m
//  BusinessLogicLayerTests
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BusinessLogicLayer.h"

@interface BusinessLogicLayerTests : XCTestCase
{
    BusinessLogicLayer *b;
}
@end

@implementation BusinessLogicLayerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    b = [[BusinessLogicLayer alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    b = nil;
}

- (void)testPrint {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    XCTAssertEqualObjects(@"print BusinessLogicLayer", b.print);
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
