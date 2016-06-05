//
//  RADotView.m
//  RadarChart
//
//  Created by qiuyaoyao on 16/6/5.
//  Copyright © 2016年 runagain. All rights reserved.
//

#import "RADotView.h"
#import "UIColor+custom.h"

@interface RADotView ()

@property (nonatomic, strong) CALayer *dotLayer;

@end

@implementation RADotView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.dotColor = [UIColor colorWithHex:0x60E6A6];
        [self.layer addSublayer:self.dotLayer];
    }
    return self;
}

- (CALayer *)dotLayer
{
    if (!_dotLayer) {
        _dotLayer = [CALayer layer];
    }
    return _dotLayer;
}

- (void)setDotColor:(UIColor *)dotColor
{
    _dotColor = dotColor;
    self.dotLayer.backgroundColor = self.dotColor.CGColor;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    float width = CGRectGetWidth(self.frame);
    self.layer.cornerRadius = width*0.5;
    
    self.dotLayer.frame = CGRectMake(1.5, 1.5, CGRectGetWidth(self.frame)-3, CGRectGetHeight(self.frame)-3);
    self.dotLayer.cornerRadius = (width-3)*0.5;
}

@end
