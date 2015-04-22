//
//  PRHTopTableViewController.m
//  PRHHealthKitSample
//
//  Created by 清 貴幸 on 2015/04/22.
//  Copyright (c) 2015年 VOYAGE GROUP. All rights reserved.
//

#import "PRHTopTableViewController.h"
#import "PRHHealthKitService.h"

@interface PRHTopTableViewController ()
@end

@implementation PRHTopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [PRHHealthKitService sharedService];
}

@end
