//
//  UIBezierPath+Pentagon.h
//  RadarChart
//
//  Created by qiuyaoyao on 16/6/5.
//  Copyright © 2016年 runagain. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBezierPath (Pentagon)

+ (CGPathRef)drawPentagonWithCenter:(CGPoint)center LengthArray:(NSArray *)lengths;

+ (CGPathRef)drawPentagonWithCenter:(CGPoint)center Length:(double)length;

+ (NSArray *)converCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center;

@end
