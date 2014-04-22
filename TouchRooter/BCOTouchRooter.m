//
//  BCOTouchRooter.m
//  BCOTouchRooter
//
//  Created by 阿部耕平 on 2014/04/22.
//  Copyright (c) 2014年 Kohei Abe. All rights reserved.
//

#import "BCOTouchRooter.h"
#import <objc/runtime.h>


// for method swizzling
@interface UIWindow (swizzling)

- (void)sendEvent_receive:(UIEvent *)event;

@end


@interface BCOTouchRooter ()

@property (nonatomic, strong) NSMutableArray *responderArray;

@end

static BCOTouchRooter *p_sharedInstance = nil;

@implementation BCOTouchRooter

- (id)init
{
    self = [super init];
    if (self) {
        _responderArray = @[].mutableCopy;
        
        // method swizzling
        [self p_processMethodSwizzlingFromClass:[UIWindow class]
                                        fromSEL:@selector(sendEvent:)
                                        toClass:[UIWindow class]
                                          toSEL:@selector(sendEvent_receive:)];
    }
    return self;
}

+ (BCOTouchRooter *)sharedRooter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        p_sharedInstance = [[BCOTouchRooter alloc] init];
    });
    return p_sharedInstance;
}

- (void)addReceiver:(id<BCOTouchReceiver>)receiver
{
    if ([_responderArray containsObject:receiver]) {
        return;
    }
    [_responderArray addObject:receiver];
}

- (void)removeReceiver:(id<BCOTouchReceiver>)receiver
{
    if ([_responderArray containsObject:receiver]) {
        [_responderArray removeObject:receiver];
    }
}

#pragma mark - private

- (void)p_processMethodSwizzlingFromClass:(Class)fromClass
                                  fromSEL:(SEL)fromSEL
                                  toClass:(Class)toClass
                                    toSEL:(SEL)toSEL
{
    Method fromMethod = class_getInstanceMethod(fromClass, fromSEL);
    Method toMethod = class_getInstanceMethod(toClass, toSEL);
    method_exchangeImplementations(fromMethod, toMethod);
}

@end


// for method swizzling
@implementation UIWindow (swizzling)

// UIWindowのsendEventをこのメソッドで置き換える。
- (void)sendEvent_receive:(UIEvent *)event
{
    // タッチイベントをレシーバに通知
    BCOTouchRooter *rooter = [BCOTouchRooter sharedRooter];
    for (id<BCOTouchReceiver> resceiver in rooter.responderArray) {
        
        // phaseごとにsetを分ける
        NSMutableSet *beganSet = [NSMutableSet setWithCapacity:0];
        NSMutableSet *movedSet = [NSMutableSet setWithCapacity:0];
        NSMutableSet *endedSet = [NSMutableSet setWithCapacity:0];
        NSMutableSet *cancelledSet = [NSMutableSet setWithCapacity:0];
        NSSet *allTouches = [event allTouches];
        for (UITouch *touch in allTouches) {
            switch (touch.phase) {
                case UITouchPhaseBegan:
                    [beganSet addObject:touch];
                    break;
                case UITouchPhaseMoved:
                    [movedSet addObject:touch];
                    break;
                case UITouchPhaseEnded:
                    [endedSet addObject:touch];
                    break;
                case UITouchPhaseCancelled:
                    [cancelledSet addObject:touch];
                    break;
                default:
                    break;
            }
        }
        
        if ([beganSet count] > 0) {
            [resceiver didReceiveTouchesBegan:beganSet event:event];
        }
        
        if ([movedSet count] > 0) {
            [resceiver didReceiveTouchesMoved:movedSet.copy event:event];
        }
        
        if ([endedSet count] > 0) {
            [resceiver didReceiveTouchesEnded:endedSet.copy event:event];
        }
        
        if ([cancelledSet count] > 0) {
            [resceiver didReceiveTouchesCancelled:cancelledSet.copy event:event];
        }
    }
    
    // 元々のsendEvent:の実装を呼ぶ
    [self sendEvent_receive:event];
}

@end
