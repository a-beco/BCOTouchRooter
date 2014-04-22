//
//  BCOViewController.m
//  BCOTouchRooter
//
//  Created by 阿部耕平 on 2014/04/22.
//  Copyright (c) 2014年 Kohei Abe. All rights reserved.
//

#import "BCOViewController.h"
#import "BCOTouchRooter.h"

@interface BCOViewController () <BCOTouchReceiver>

@end

@implementation BCOViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        BCOTouchRooter *rooter = [BCOTouchRooter sharedRooter];
        [rooter addReceiver:self];
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"began");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"moved");
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ended");
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"cancelled");
}

#pragma mark - BCOTouchReceiver

- (void)didReceiveTouchesBegan:(NSSet *)touches event:(UIEvent *)event
{
    NSLog(@"began rooter");
}

- (void)didReceiveTouchesMoved:(NSSet *)touches event:(UIEvent *)event
{
    NSLog(@"moved rooter");
}

- (void)didReceiveTouchesEnded:(NSSet *)touches event:(UIEvent *)event
{
    NSLog(@"ended rooter");
}

- (void)didReceiveTouchesCancelled:(NSSet *)touches event:(UIEvent *)event
{
    NSLog(@"cancelled rooter");
}

@end
