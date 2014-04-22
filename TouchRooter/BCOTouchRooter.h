//
//  BCOTouchRooter.h
//  BCOTouchRooter
//
//  Created by 阿部耕平 on 2014/04/22.
//  Copyright (c) 2014年 Kohei Abe. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * addReceiver:で追加されたレシーバオブジェクトに対し、
 * 全てのタッチイベントを渡すクラス。
 * タッチされていないオブジェクトにもタッチを通知できる。
 */
@protocol BCOTouchReceiver;
@interface BCOTouchRooter : NSObject

+ (BCOTouchRooter *)sharedRooter;

- (void)addReceiver:(id<BCOTouchReceiver>)receiver;
- (void)removeReceiver:(id<BCOTouchReceiver>)receiver;

@end


@protocol BCOTouchReceiver <NSObject>

@required
- (void)didReceiveTouchesBegan:(NSSet *)touches event:(UIEvent *)event;
- (void)didReceiveTouchesMoved:(NSSet *)touches event:(UIEvent *)event;
- (void)didReceiveTouchesEnded:(NSSet *)touches event:(UIEvent *)event;
- (void)didReceiveTouchesCancelled:(NSSet *)touches event:(UIEvent *)event;

@end