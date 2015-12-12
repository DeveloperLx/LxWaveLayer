//
//  LxWaveLayer.h
//  LxWaveAnimationDemo
//
//  Created by DeveloperLx on 15/12/11.
//  Copyright © 2015年 DeveloperLx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LxWaveLayer : CAShapeLayer

@property (nonatomic,assign) CGFloat waveHeight;
@property (nonatomic,assign) CGFloat waveAmplitude;
@property (nonatomic,assign) NSTimeInterval wavePeriod;
@property (nonatomic,assign) CGFloat waveSpeed;
@property (nonatomic,assign) CGFloat wavePhase;

- (void)deployOnView:(UIView *)view;

- (void)beginWaveAnimation;
- (void)stopWaveAnimation;

@end
