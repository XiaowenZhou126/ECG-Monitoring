//
//  PersistenceLayerTests.m
//  PersistenceLayerTests
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PersistenceLayer.h"

@interface PersistenceLayerTests : XCTestCase
{
    PersistenceLayer *p;
}
@end

@implementation PersistenceLayerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    p = [[PersistenceLayer alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    p = nil;
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
