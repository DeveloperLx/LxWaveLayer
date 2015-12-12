//
//  LxWaveLayer.m
//  LxWaveAnimationDemo
//
//  Created by DeveloperLx on 15/12/11.
//  Copyright © 2015年 DeveloperLx. All rights reserved.
//

#import "LxWaveLayer.h"

#define DEFAULT_WAVE_COLOR [UIColor colorWithRed:0.098 green:0.651 blue:0.996 alpha:1]

static CGFloat const DEFAULT_WAVE_HEIGHT = 180;
static CGFloat const DEFAULT_WAVE_AMPLITUDE = 6;
static CGFloat const DEFAULT_WAVE_SPEED = 270;
static CGFloat const DEFAULT_WAVE_PHASE = 0;
static NSTimeInterval const DEFAULT_WAVE_PERIOD = 240;

@interface LxWaveLayer ()
{
    CADisplayLink * _displayLink;
}

@end

@implementation LxWaveLayer

- (instancetype)init
{
    if (self = [super init]) {
        
        self.fillColor = DEFAULT_WAVE_COLOR.CGColor;
        self.waveHeight = DEFAULT_WAVE_HEIGHT;
        self.waveAmplitude = DEFAULT_WAVE_AMPLITUDE;
        self.waveSpeed = DEFAULT_WAVE_SPEED;
        self.wavePhase = DEFAULT_WAVE_PHASE;
        self.wavePeriod = DEFAULT_WAVE_PERIOD;
        
        [self addObserver:self forKeyPath:@"bounds" options:NSKeyValueObservingOptionNew context:NULL];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"bounds"]) {
        CGRect newBounds = [change[@"new"] CGRectValue];
        if (CGRectGetWidth(newBounds) > 0 && CGRectGetHeight(newBounds) > 0) {
            [self updateBoundary:nil];
        }        
    }
}

- (void)updateBoundary:(CADisplayLink *)displayLink
{
    UIBezierPath * boundaryPath = [[UIBezierPath alloc]init];
    
    CGFloat layerWidth = CGRectGetWidth(self.bounds);
    CGFloat layerHeight = CGRectGetHeight(self.bounds);
    
    [boundaryPath moveToPoint:CGPointMake(0, layerHeight)];
    [boundaryPath addLineToPoint:CGPointMake(0, layerHeight - self.waveHeight)];

    for (CGFloat x = 0; x <= CGRectGetWidth(self.bounds); x++) {
        
        CGFloat y = self.waveAmplitude * sin(2 * M_PI/self.wavePeriod * x + 2 * M_PI/self.wavePeriod * displayLink.timestamp * self.waveSpeed) + layerHeight - self.waveHeight;
        [boundaryPath addLineToPoint:CGPointMake(x, y)];
    }

    [boundaryPath addLineToPoint:CGPointMake(layerWidth, layerHeight)];
    [boundaryPath closePath];
    
    self.path = boundaryPath.CGPath;
}

- (void)deployOnView:(UIView *)view
{
    self.bounds = view.bounds;
    self.anchorPoint = CGPointZero;
    [view.layer addSublayer:self];
}

- (void)beginWaveAnimation
{
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateBoundary:)];
    _displayLink.frameInterval = 3;
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopWaveAnimation
{
    [_displayLink invalidate];
    _displayLink = nil;
}

@end
