//
//  PRHPNChartViewController.m
//  PRHHealthKitSample
//
//  Created by 清 貴幸 on 2015/04/23.
//  Copyright (c) 2015年 VOYAGE GROUP. All rights reserved.
//

#import "PRHPNChartViewController.h"
#import <PNChart.h>
#import "PRHHealthKitService.h"
#import <NSDate+Escort.h>

@interface PRHPNChartViewController ()

@end

@implementation PRHPNChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    __block PNLineChart *lineChart = [[PNLineChart alloc] initWithFrame:(CGRect){0, 200, 320, 200}];
    [[PRHHealthKitService sharedService] stepCountCollectionWithCompletionHandler:^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            PNLineChartData *data = [PNLineChartData new];
            data.itemCount = 5;
            data.getData = ^(NSUInteger index) {
                HKStatistics *statistics = result.statistics[index];
                CGFloat stepCount = [[statistics sumQuantity] doubleValueForUnit:nil];
                return [PNLineChartDataItem dataItemWithY:stepCount];
            };
            
            NSMutableArray *xLabels = [NSMutableArray new];
            [result enumerateStatisticsFromDate:[NSDate dateWithDaysBeforeNow:data.itemCount + 1]
                                         toDate:[NSDate date]
                                      withBlock:^(HKStatistics *result, BOOL *stop) {
                                          [xLabels addObject:[result.startDate.description substringToIndex:10]];
                                      }];
            
            [lineChart setXLabels:xLabels];
            lineChart.chartData = @[data];
            [lineChart strokeChart];
        });
    }];

    [self.view addSubview:lineChart];
}

@end
