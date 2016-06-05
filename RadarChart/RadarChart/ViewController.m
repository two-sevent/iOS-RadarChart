//
//  ViewController.m
//  RadarChart
//
//  Created by qiuyaoyao on 16/6/5.
//  Copyright © 2016年 runagain. All rights reserved.
//

#import "ViewController.h"
#import "RAShareChartView.h"

@interface ViewController ()

@property (nonatomic, strong) RAShareChartView *chartV;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.chartV.center = self.view.center;
    [self.view addSubview:self.chartV];
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(1.5)];
    [array addObject:@(2.0)];
    [array addObject:@(4.4)];
    [array addObject:@(3.8)];
    [array addObject:@(0.7)];
    
    self.chartV.scoresArray = array;
    // Do any additional setup after loading the view, typically from a nib.
}


-(RAShareChartView *)chartV
{
    if (!_chartV) {
        _chartV = [[RAShareChartView alloc] init];
        _chartV.bounds = CGRectMake(0, 0, 590 / 2.0, 462 / 2.0);
    }
    return _chartV;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
