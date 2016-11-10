//
//  XCRaceView.m
//  XCRaceView
//
//  Created by wangwenke on 16/9/13.
//  Copyright © 2016年 wangwenke. All rights reserved.
//

#import "XCMarqueeView.h"

#define RACE_SPEED     60.0
#define RACE_FONT      [UIFont systemFontOfSize:15.0]

@interface XCMarqueeView()

@property (nonatomic, strong) UILabel *raceLabelOne;
@property (nonatomic, strong) UILabel *raceLabelTwo;
@property (nonatomic, strong) NSTimer *raceTimer;
@property (nonatomic, strong) NSMutableArray *raceLabelArray;

@end

@implementation XCMarqueeView

- (NSMutableArray *)raceLabelArray{
    if (!_raceLabelArray) {
        self.raceLabelArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _raceLabelArray;
}

- (nonnull instancetype)initWithFrame:(CGRect)frame andRaceTitle:(nonnull NSString*)racetitle{
    self = [super initWithFrame:frame];
    if (self) {
        NSString *raceStr = [NSString stringWithFormat:@"%@    ",racetitle];
        
        _raceLabelOne = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, [self getStringWidth:raceStr], frame.size.height)];
        _raceLabelOne.font = RACE_FONT;
        _raceLabelOne.textColor = [UIColor whiteColor];
        _raceLabelOne.textAlignment = NSTextAlignmentCenter;
        _raceLabelOne.text = raceStr;
        
        
        _raceLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(_raceLabelOne.frame.origin.x + _raceLabelOne.bounds.size.width, _raceLabelOne.frame.origin.y, _raceLabelOne.bounds.size.width, _raceLabelOne.bounds.size.height)];
        _raceLabelTwo.font = RACE_FONT;
        _raceLabelTwo.textColor = [UIColor whiteColor];
        _raceLabelTwo.textAlignment = NSTextAlignmentCenter;
        _raceLabelTwo.text = raceStr;
        [self addSubview:_raceLabelOne];
        [self addSubview:_raceLabelTwo];
        [self.raceLabelArray addObject:_raceLabelOne];
        [self.raceLabelArray addObject:_raceLabelTwo];
        _raceLabelTwo.hidden = ![self isNeedRaceAnimate];
        
    }
    return self;
}

- (void)changeRaceTitle:(nonnull NSString*)raceTitle{
    if (_raceTimer) {
        [_raceTimer invalidate];
        _raceTimer = nil;
    }
    NSString *raceStr = [NSString stringWithFormat:@"%@    ",raceTitle];
    _raceLabelOne.frame = CGRectMake(0, 0, [self getStringWidth:raceStr], self.bounds.size.height);
    _raceLabelTwo.frame = CGRectMake(_raceLabelOne.frame.origin.x + _raceLabelOne.bounds.size.width, _raceLabelOne.frame.origin.y, _raceLabelOne.bounds.size.width, _raceLabelOne.bounds.size.height);
    _raceLabelOne.text = raceStr;
    _raceLabelTwo.text = raceStr;
    _raceLabelTwo.hidden = ![self isNeedRaceAnimate];
    if ([self isNeedRaceAnimate]) {
        [self startRaceAnimate];
    }
}

- (BOOL)isNeedRaceAnimate{
    return !(_raceLabelOne.bounds.size.width <= self.bounds.size.width);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (_raceTimer) {
        [_raceTimer invalidate];
        _raceTimer = nil;
    }
    if (_raceLabelOne && _raceLabelTwo) {
        _raceLabelOne.frame = CGRectMake(0, 0, _raceLabelOne.bounds.size.width, self.bounds.size.height);
        _raceLabelTwo.frame = CGRectMake(_raceLabelOne.frame.origin.x + _raceLabelOne.bounds.size.width, _raceLabelOne.frame.origin.y, _raceLabelOne.bounds.size.width, _raceLabelOne.bounds.size.height);
    }
    _raceLabelTwo.hidden = ![self isNeedRaceAnimate];
    if ([self isNeedRaceAnimate]) {
        [self startRaceAnimate];
    }
}


- (void)startRaceAnimate{
    _raceTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / RACE_SPEED target:self selector:@selector(raceLabelFrameChanged:) userInfo:nil repeats:YES];
    [_raceTimer fire];
    [[NSRunLoop mainRunLoop] addTimer:_raceTimer forMode:NSRunLoopCommonModes];
}

- (void)raceLabelFrameChanged:(NSTimer *)timer{
    UILabel *labelOne = [self.raceLabelArray firstObject];
    UILabel *labelTwo = [self.raceLabelArray lastObject];
    CGRect frameOne = labelOne.frame;
    CGRect frameTwo = labelTwo.frame;
    CGFloat firstX = labelOne.frame.origin.x;
    CGFloat secondX = labelTwo.frame.origin.x;
    firstX -= 0.5;
    secondX -= 0.5;
    if (ABS(firstX) >= labelOne.bounds.size.width) {
        firstX = secondX + labelOne.bounds.size.width;
        [self.raceLabelArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
    }
    frameOne.origin.x = firstX;
    frameTwo.origin.x = secondX;
    labelOne.frame = frameOne;
    labelTwo.frame = frameTwo;
}

- (void)resume{
    [self resumeAndStart:NO];
}

- (void)resumeAndStart{
    [self resumeAndStart:YES];
}

- (void)resumeAndStart:(BOOL)start{
    if (_raceTimer) {
        [_raceTimer invalidate];
        _raceTimer = nil;
    }
    _raceLabelOne.frame = CGRectMake(0, 0, _raceLabelOne.bounds.size.width, self.bounds.size.height);
    _raceLabelTwo.frame = CGRectMake(_raceLabelOne.frame.origin.x + _raceLabelOne.bounds.size.width, _raceLabelOne.frame.origin.y, _raceLabelOne.bounds.size.width, _raceLabelOne.bounds.size.height);
    if (start) {
        [self startRaceAnimate];
    }
}

- (CGFloat)getStringWidth:(NSString *)string{
    if (string) {
        CGRect rect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 0)
                                         options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |
                       NSStringDrawingUsesFontLeading
                                        attributes:@{NSFontAttributeName:RACE_FONT}
                                         context:nil];
        return rect.size.width;
    }
    return 0.f;
}

@end
