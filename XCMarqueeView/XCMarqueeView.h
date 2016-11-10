//
//  XCRaceView.h
//  XCRaceView
//
//  Created by wangwenke on 16/9/13.
//  Copyright © 2016年 wangwenke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XCMarqueeView : UIView

- (nonnull instancetype)initWithFrame:(CGRect)frame andRaceTitle:(nonnull NSString*)racetitle;

- (void)changeRaceTitle:(nonnull NSString*)raceTitle;

- (void)resume;

@end
