//
//  BCOTouchView.m
//  BCOTouchRooter
//
//  Created by 阿部耕平 on 2014/04/25.
//  Copyright (c) 2014年 Kohei Abe. All rights reserved.
//

#import "BCOTouchView.h"
#import "BCOTouchRooter.h"

@interface BCOTouchView () <BCOTouchReceiver>
@end

@implementation BCOTouchView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        BCOTouchRooter *rooter = [BCOTouchRooter sharedRooter];
        [rooter addReceiver:self];
        
        BCOTouchFilter *filter = [rooter filterForReceiver:self];
        filter.blockMask |= BCOTouchFilterMaskNotHitView;
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"began view");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"moved view");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ended view");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"cancelled view");
}

#pragma mark - BCOTouchReceiver

- (void)didReceiveTouchesBegan:(NSSet *)touches event:(UIEvent *)event
{
    NSLog(@"began view rooter");
}

- (void)didReceiveTouchesMoved:(NSSet *)touches event:(UIEvent *)event
{
    NSLog(@"moved view rooter");
}

- (void)didReceiveTouchesEnded:(NSSet *)touches event:(UIEvent *)event
{
    NSLog(@"ended view rooter");
}

- (void)didReceiveTouchesCancelled:(NSSet *)touches event:(UIEvent *)event
{
    NSLog(@"cancelled view rooter");
}

@end
