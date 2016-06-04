//
//  View.h
//  组排按钮封装
//
//  Created by SJ on 16/5/26.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#warning 以后代理在没有相互导入的情况下最好跟调用代理的视图控制器写在一起,下面是代理的写法

@protocol ViewPassValueDalegate <NSObject>

-(void)passData:(NSString *)str;

@end


@interface View : UIView

#pragma mark .h成员变量（外部接口），你现在下面只有两个方法，所以直接当成参数传进方法里面，如果下面有10个方法，难道你在CTRL里面调用的时候每个方法都要传一遍么，而且这种方式在你.m文件里面的任何私有方法都可以调用这些参数，这是面向对象的思想，多写。
@property (nonatomic, strong) NSMutableArray *numArray;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, assign) CGSize btnSize;
@property(nonatomic,weak)UILabel *selectLable1;
@property(nonatomic,weak)UILabel *selectLable2;
@property (weak, nonatomic) id<ViewPassValueDalegate> delegate;





//-(void)autoFrame: (NSMutableArray *)numberArray :(CGSize)buttonSize;
//-(void)createButton:(NSMutableArray *)numberArray :(NSMutableArray *)titleArray :(CGSize)buttonSize;
-(void)cancelButtonInteraction;
-(void)choseOneButton:(int)index;
-(CGSize)getViewSize;
//-(NSString *)getFrame;


@end
