//
//  UIBezierPath+Pentagon.m
//  RadarChart
//
//  Created by qiuyaoyao on 16/6/5.
//  Copyright © 2016年 runagain. All rights reserved.
//

#import "UIBezierPath+Pentagon.h"

@implementation UIBezierPath (Pentagon)

+ (CGPathRef)drawPentagonWithCenter:(CGPoint)center Length:(double)length
{
    NSArray *lengths = [NSArray arrayWithObjects:@(length),@(length),@(length),@(length),@(length), nil];
    return [self drawPentagonWithCenter:center LengthArray:lengths];
}

+ (CGPathRef)drawPentagonWithCenter:(CGPoint)center LengthArray:(NSArray *)lengths
{
    NSArray *coordinates = [self converCoordinateFromLength:lengths Center:center];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    for (int i = 0; i < [coordinates count]; i++) {
        CGPoint point = [[coordinates objectAtIndex:i] CGPointValue];
        if (i == 0) {
            [bezierPath moveToPoint:point];
        } else {
            [bezierPath addLineToPoint:point];
        }
    }
    [bezierPath closePath];
    
    return bezierPath.CGPath;
}

+ (NSArray *)converCoordinateFromLength:(NSArray *)lengthArray Center:(CGPoint)center
{
    NSMutableArray *coordinateArray = [NSMutableArray array];
    for (int i = 0; i < [lengthArray count] ; i++) {
        double length = [[lengthArray objectAtIndex:i] doubleValue];
        CGPoint point = CGPointZero;
        if (i == 0) {
            point =  CGPointMake(center.x - length * sin(M_PI / 5.0),
                                 center.y - length * cos(M_PI / 5.0));
        } else if (i == 1) {
            point = CGPointMake(center.x + length * sin(M_PI / 5.0),
                                center.y - length * cos(M_PI / 5.0));
        } else if (i == 2) {
            point = CGPointMake(center.x + length * cos(M_PI / 10.0),
                                center.y + length * sin(M_PI / 10.0));
        } else if (i == 3) {
            point = CGPointMake(center.x,
                                center.y +length);
        } else {
            point = CGPointMake(center.x - length * cos(M_PI / 10.0),
                                center.y + length * sin(M_PI / 10.0));
        }
        
        [coordinateArray addObject:[NSValue valueWithCGPoint:point]];
    }
    return coordinateArray;
}

@end
