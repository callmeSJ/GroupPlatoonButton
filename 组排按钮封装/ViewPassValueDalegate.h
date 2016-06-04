//
//  ViewPassValueDalegate.h
//  组排按钮封装
//
//  Created by SJ on 16/5/27.
//  Copyright © 2016年 SJ. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol ViewPassValueDalegate <NSObject>

@optional
-(void)passData:(NSString *)str;

@end
