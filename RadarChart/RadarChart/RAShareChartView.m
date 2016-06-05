//
//  RAShareChartView.m
//  Running_0.1
//
//  Created by qiuyaoyao on 16/4/18.
//  Copyright © 2016年 qiuyaoyao. All rights reserved.
//

#import "RAShareChartView.h"
#import "RADotView.h"
#import "UIColor+custom.h"
#import "UIBezierPath+Pentagon.h"

#define kRScrollAlertViewWidth 590/2.0

@interface RAShareChartView ()

@property (nonatomic, strong) NSMutableArray *dotArrays;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;
@property (nonatomic, strong) NSMutableArray *dot1Arrays;
@property (nonatomic, strong) UIImageView *bgIV;

@end

@implementation RAShareChartView

- (instancetype) init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithHex:0xFBFBFB];
        [self drawBgPentagon];
    }
    return  self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setScoresArray:(NSArray *)scoresArray
{
    _scoresArray = scoresArray;
    [self drawScorePentagonV];
}

- (CAShapeLayer *)shapeLayer
{
    if (!_shapeLayer) {
        _shapeLayer = [CAShapeLayer layer];
        _shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        _shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        _shapeLayer.fillColor = [UIColor  colorWithHex:0xfa8642 alpha:0.5].CGColor;
    }
    return _shapeLayer;
}

- (NSNumber *)convertLengthFromScore:(double)score
{
    if (score >= 4) {
        return @(12 + 22 + 30 + 30);
    } else if (score >= 3){
        return @(12 + 22 + 30 + 30 * (score - 3));
    } else if (score >= 2) {
        return @(12 + 22 + 30 * (score - 2));
    } else if (score >= 1) {
        return @(12 + 22 * (score - 1));
    } else  {
        return @(12 * score);
    }
}

- (NSArray *)convertLengthsFromScore:(NSArray *)scoreArray
{
    NSMutableArray *lengthArray = [NSMutableArray array];
    for (int i = 0; i < [scoreArray count]; i++) {
        double score = [[scoreArray objectAtIndex:i] doubleValue];
        [lengthArray addObject:[self convertLengthFromScore:score]];
    }
    return lengthArray;
}

- (NSArray *)sortMergeScoresArray:(NSArray *)scores
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i = 0; i < [scores count]; i++) {
        [dic setObject:@"scoresValue" forKey:[scores objectAtIndex:i]];
    }
    
    NSMutableArray *sortArray = [NSMutableArray arrayWithArray:dic.allKeys];
    for (int i = 0; i < [sortArray count] - 1; i++) {
        for (int j = 0; j < [sortArray count] - i - 1 ; j++) {
            if ([[sortArray objectAtIndex:j] doubleValue] > [[sortArray objectAtIndex:j + 1] doubleValue]) {
                [sortArray exchangeObjectAtIndex:j withObjectAtIndex:j + 1];
                
            }
        }
    }
    return  sortArray;
}

- (NSArray *)analysisDurationArray:(NSArray *)scores
{
    NSMutableArray *analysisArray = [NSMutableArray array];
    NSArray *sortArray = [self sortMergeScoresArray:scores];
    double lastProportion = 0;
    [analysisArray addObject:@(0)];
    for (int i = 0; i < [sortArray count]; i++) {
        double currentProportion = [[sortArray objectAtIndex:i] doubleValue] / [[sortArray lastObject] doubleValue];
        [analysisArray addObject:@(currentProportion)];
         lastProportion = currentProportion;
    }
    return analysisArray;
}

- (NSArray *)analysisScoreArray:(NSArray *)scores
{
    NSArray *sortArray = [self sortMergeScoresArray:scores];
    
    NSMutableArray *analysisArray = [NSMutableArray array];
    
    for (int i = 0; i < [sortArray count]; i++) {
        double stepScore = [[sortArray objectAtIndex:i] doubleValue];
        NSMutableArray *analysisScores = [NSMutableArray array];
        for (int j = 0; j < [scores count]; j++) {
            double score = [[scores objectAtIndex:j] doubleValue];
            if (stepScore > score) {
                [analysisScores addObject:@(score)];
            } else {
                [analysisScores addObject:@(stepScore)];
            }
        }
        [analysisArray addObject:analysisScores];
    }
    return analysisArray;
}

#pragma mark - 描绘背景五边行  按等比放大

- (void)drawBgPentagon
{
    NSArray *colors = [NSArray arrayWithObjects:
                       [UIColor colorWithHex:0xfa8642 alpha:0.1],
                       [UIColor  colorWithHex:0xfa8642 alpha:0.15],
                       [UIColor  colorWithHex:0xfa8642 alpha:0.2],
                       [UIColor  colorWithHex:0xfa8642 alpha:0.3],nil];
    
    
    for (int i = 0; i < 4; i++) {
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        UIColor *fillColor = [colors objectAtIndex:i];
        shapeLayer.fillColor = fillColor.CGColor;
        shapeLayer.path = [UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 100.0) Length:[[self convertLengthFromScore:4 - i] doubleValue]];
        [self.layer addSublayer:shapeLayer];
    }
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"技术",@"力量",@"速度",@"耐力",@"进步", nil];
    NSArray *centerArray = [NSArray arrayWithObjects:
                            [NSValue valueWithCGPoint:CGPointMake(90,15)],
                            [NSValue valueWithCGPoint:CGPointMake(204, 15)],
                            [NSValue valueWithCGPoint:CGPointMake(247, 140)],
                            [NSValue valueWithCGPoint:CGPointMake(149, 204)],
                            [NSValue valueWithCGPoint:CGPointMake(50, 140)],nil];
    for (int i = 0; i < [titleArray count]; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor colorWithHex:0xAAAAAA];
        label.textAlignment = NSTextAlignmentCenter;
        label.bounds = CGRectMake(0, 0, 24, 11);
        label.center = [[centerArray objectAtIndex:i] CGPointValue];
        label.font = [UIFont systemFontOfSize:10];
        label.text = [titleArray objectAtIndex:i];
        [self addSubview:label];
    }
}

#pragma mark - 描绘分数五边行  按等比放大
- (void)drawScorePentagonV
{
    NSArray *lengthsArray = [self convertLengthsFromScore:self.scoresArray];
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    pathAnimation.fromValue = (id)[UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 100.0) Length:0];
    pathAnimation.toValue = (id)[UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 100.0) LengthArray:lengthsArray];
    pathAnimation.duration = 0.75;
    pathAnimation.autoreverses = NO;
    pathAnimation.repeatCount = 0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.shapeLayer addAnimation:pathAnimation forKey:@"scale"];
    self.shapeLayer.path = [UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 100.0) LengthArray:lengthsArray];
    [self.layer addSublayer:self.shapeLayer];
    
    [self performSelector:@selector(changeBgSizeFinish) withObject:nil afterDelay:0.75];
}

#pragma mark - 描绘分数五边行  按分数比例放大
//- (void)drawScorePentagonV
//{
//    NSArray *scoresArray = [self analysisScoreArray:self.scoresArray];
//    NSMutableArray *lengthsArray = [NSMutableArray array];
//    [lengthsArray addObject:(id)[UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 231 / 2.0) Length:0.0]];
//    for (int i = 0; i < [scoresArray count]; i++) {
//        NSArray *scores = [scoresArray objectAtIndex:i];
//        [lengthsArray addObject:(id)[UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 231 / 2.0) LengthArray:[self convertLengthsFromScore:scores]]];
//    }
//    CAKeyframeAnimation *frameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"path"];
//    frameAnimation.values = lengthsArray;
//    frameAnimation.keyTimes = [self analysisDurationArray:self.scoresArray];
//    frameAnimation.duration = 2;
//    frameAnimation.calculationMode = kCAAnimationLinear;
//
//    [self.shapeLayer addAnimation:frameAnimation forKey:@"scale"];
//    self.shapeLayer.path = [UIBezierPath drawPentagonWithCenter:CGPointMake(kRScrollAlertViewWidth / 2.0, 231 / 2.0) LengthArray:[self convertLengthsFromScore:[scoresArray lastObject]]];
//    [self.layer addSublayer:self.shapeLayer];
    

//    [self performSelector:@selector(changeBgSizeFinish) withObject:nil afterDelay:2];
//}

#pragma mark - 描点
- (void)changeBgSizeFinish
{
     NSArray *array = [self convertLengthsFromScore:self.scoresArray];
    NSArray *lengthsArray = [UIBezierPath converCoordinateFromLength:array Center:CGPointMake(kRScrollAlertViewWidth / 2.0, 100.0)];
    for (int i = 0; i < [lengthsArray count]; i++) {
        CGPoint point = [[lengthsArray objectAtIndex:i] CGPointValue];
        RADotView *view = [[RADotView alloc] init];
        view.dotColor = [UIColor colorWithHex:0xF86465];
        view.center = point;
        view.bounds = CGRectMake(0, 0, 8, 8);
        [self addSubview:view];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
