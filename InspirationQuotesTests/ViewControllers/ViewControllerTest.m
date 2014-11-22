//
//  ViewControllerTest.m
//  InspirationQuotes
//
//  Created by Deniss Kaibagarovs on 11/18/14.
//  Copyright (c) 2014 Deniss Kaibagarovs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "ViewController_PrivateTestMethods.h"

@interface ViewControllerTest : XCTestCase {
    ViewController *controller;
}

@end

@implementation ViewControllerTest

- (void)setUp {
    [super setUp];
    controller = [[ViewController alloc]init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSharingText {
    XCTAssert([controller getSharingText]);
}

@end
