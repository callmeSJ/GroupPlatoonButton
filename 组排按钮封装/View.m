//
//  View.m
//  组排按钮封装
//
//  Created by SJ on 16/5/26.
//  Copyright © 2016年 SJ. All rights reserved.
//

#import "View.h"

#define ButtonSize  80,40
#define ButtonLineSpace  70
#define ButtonRowSpace  40

@implementation View


- (void)drawRect:(CGRect)rect {
#pragma mark 绘制方法，这个方法在外部调用addSubview方法时会调用
    [self createBtn];
    [self createAddBtn];
}


#pragma mark 获取自身尺寸
-(CGSize)getViewSize{
    int count = 0;
    int temp = 0;
    
    for(NSString *i in _numArray){
        int i1 = [i intValue];
        if(i1 > temp){
            temp = i1;
        }
        count ++;
    }
    NSLog(@"%d",temp);
    float width = _btnSize.width * temp + ButtonLineSpace * (temp - 1);
    float height = _btnSize.height * count + ButtonRowSpace * (count - 1);
    return CGSizeMake(width, height);
}

#pragma mark 创建按钮
-(void)createBtn{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef borderColor = CGColorCreate(colorSpace, (CGFloat[]){0,1,1,1});

    float x = 50;
    float y = 50;

    NSInteger titleCount = 0;
    
    for (NSString *i in _numArray) {
        int i1 = [i intValue];
        NSLog(@"i = %d",i1);
        for (int j= 0  ; j < i1 ; j++){
            if(j == 0){
                y = y + ButtonRowSpace;
                
            }
            UILabel *lable =[[UILabel alloc]init];
            [lable setFrame:CGRectMake(x +  ButtonLineSpace * j, y ,_btnSize.width, _btnSize.height)];
            [lable.layer setMasksToBounds:YES];
            [lable.layer setCornerRadius:10.0];
            [lable.layer setBorderWidth:1.5];
            [lable.layer setBorderColor:borderColor];
            [lable setTextAlignment:NSTextAlignmentCenter];
            [lable setText:_titleArray[titleCount]];
            [lable setTextColor:[UIColor grayColor]];
            [lable setUserInteractionEnabled:YES];
            [lable setBackgroundColor:[UIColor whiteColor]];
            [lable setTag:(titleCount + 100)];
            [self addSubview:lable];
#warning 这个封装还不错
            [self doubleTapsWithTarget:lable];
            
//            [self oneTapWithTarget:lable];
            titleCount++;
            
            
//            UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//            [btn setFrame:CGRectMake(x +  ButtonLineSpace * j, y ,_btnSize.width, _btnSize.height)];
//            [btn.layer setMasksToBounds:YES];
//            [btn.layer setCornerRadius:10.0];
//            [btn setTitle:_titleArray[titleCount] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//            [btn.layer setBorderWidth:1.5 ];
//            [btn.layer setBorderColor:borderColor];
//            [btn setBackgroundColor:[UIColor whiteColor]];
//            [btn setTintColor:[UIColor purpleColor]];
//            [btn setSelected:NO];
//            [btn setTag:(titleCount + 100)];
//            [self addSubview:btn];
//            [self doubleTapsWithTarget:btn];
//            [btn addTarget:self action:@selector(btn_click:)forControlEvents:UIControlEventTouchUpInside];
//            titleCount++;
        }
    }
}



#pragma mark 取消交互
-(void)cancelButtonInteraction{

    for (UIView *view in self.subviews) {
        view.userInteractionEnabled = NO;
    }

}


#pragma mark 设置选择项
-(void)choseOneButton:(int)index{

    
    for(int i = 100; i < (_titleArray.count +100) ; i++){
        UIButton *btn = [self viewWithTag:i];
        if(btn.selected == YES){
            btn.selected = NO;
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
    
    UIButton *button = [self viewWithTag:(index+101)];
    button.selected = YES;
    button.backgroundColor = [UIColor purpleColor];
    
}

//#pragma mark 点击触发事件
//-(void)btn_click:(UILabel*)sender{
//    for(int i = 100;i < (_titleArray.count + 100); i ++)
//    {
//        UILabel *lable = [self viewWithTag:i];
////        UIButton *button = [self viewWithTag:i];
//        if(lable == sender){
//            lable.userInteractionEnabled = NO;
//        }else{
//            lable.backgroundColor = [UIColor whiteColor];
//            lable.userInteractionEnabled = YES;
//        }
//    }
//    if(sender.userInteractionEnabled == YES){
//        sender.backgroundColor = [UIColor redColor];
//        [self.delegate passData:sender.text];
//
//    }
//    
//}

#pragma mark 创建动画
-(void)animation: (UILabel *)button1 button2:(UILabel *)button2{
    
    NSLog(@"%@,%@",NSStringFromCGRect(button1.frame),NSStringFromCGPoint(button1.frame.origin));
    
    NSLog(@"%@,%@",NSStringFromCGRect(button2.frame),NSStringFromCGPoint(button1.frame.origin));
    
    CGFloat btn1PointX = button1.frame.origin.x;
    CGFloat btn1PointY = button1.frame.origin.y;
    
    CGFloat btn2PointX = button2.frame.origin.x;
    CGFloat btn2PointY = button2.frame.origin.y;
    
    
    [UIView animateWithDuration:1 animations:^{
        
        [button1 setFrame:CGRectMake(btn2PointX, btn2PointY, button2.frame.size.width, button2.frame.size.height)];
        
        [button2 setFrame:CGRectMake(btn1PointX, btn1PointY, button1.frame.size.width, button1.frame.size.height)];
    } completion:^(BOOL finished) {
#warning 下面的单击手势修改后需要增加的代码块
        [_selectLable1 setUserInteractionEnabled:YES];
        [_selectLable1 setBackgroundColor:[UIColor whiteColor]];
        [_selectLable1 setTextColor:[UIColor grayColor]];
        
        [_selectLable2 setUserInteractionEnabled:YES];
        [_selectLable2 setBackgroundColor:[UIColor whiteColor]];
        [_selectLable2 setTextColor:[UIColor grayColor]];
        NSInteger t1 = _selectLable1.tag;
        NSInteger t2 = _selectLable2.tag;
        [_selectLable1 setTag:t2];
       

        [_selectLable2 setTag:t1];
      
        _selectLable1 = nil;
        _selectLable2 = nil;
    }];
}
//左移动动画
-(void)leftMoveAnimationWithLable: (UILabel *)lable{
    
    long tag = lable.tag - 100;

#warning 注释不对，temp最后取到的值为这行最后的label的tag值+1，程序员都是从0开始数数的，count和index的本质搞清楚
    //之前写的时候，就有想到这个。 但直接后面改了，没把这tag值改成真正的tag值。
    //这行最后lable的tag值
    int temp = 0;
    for(NSNumber *i in _numArray){
        int i1 = [i intValue];
        if(temp <= tag){
            temp = temp + i1;
        }else{
            break;
        }
    }
    temp = temp - 1;
    NSLog(@"这行最后的tag = %d",temp);
    
#warning 上面的temp理解错误这里还能给你写对了，你这个逻辑也是突破天际，如果temp是最后一个Label的tag值的话，那条件就该改成i<=(temp+100)
    //
    [UIView animateWithDuration:1 animations:^{
        for(long i = tag + 100 ; i <= (temp + 100) ; i++ ){
            UILabel *lab = [self viewWithTag:i];
        [lab setFrame:CGRectMake(lab.frame.origin.x - ButtonLineSpace, lab.frame.origin.y
                                   , lab.frame.size.width, lab.frame.size.height)];
        }
    } completion:^(BOOL finished) {
        NSLog(@"lable删除");
    }];
}


#pragma mark 创建手势
//双击手势
-(void)doubleTapsWithTarget:(id)sender{
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    tap2.numberOfTapsRequired = 2;
    [sender addGestureRecognizer:tap2];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneTap:)];
    tap1.numberOfTapsRequired = 1;
    [sender addGestureRecognizer:tap1];
    [tap1 requireGestureRecognizerToFail:tap2];
    
}
//双击手势的方法
-(void)handleTap: (UITapGestureRecognizer *)aTap{
    
    long itag = aTap.view.tag - 100;
#warning 484撒。。。。你这行代码取到的view不就是aTap.view吗= =

    //    UILabel *lable = [self viewWithTag:aTap.view.tag];
    UILabel *lable = (UILabel *)aTap.view;
    int indexTitle = 0;
    

    
    //判断是在titleArray第几个
#warning 这个label跟上面那个label又有什么区别，为什么要取两次。。。。而且indexTitle不就是你的itag的值吗？你的tag本来就是靠着循环创建的，这点联想总该有吧
    //= = 对的。。
//    UILabel *lableTmp = [self viewWithTag:(aTap.view.tag)];
//    
//    for(NSString *j in _titleArray){
//        NSLog(@"lableTmp.text %@, j = %@",lable.text,j);
//        if([lable.text isEqualToString:j]){
//            NSLog(@"titleArray的第%d个",indexTitle);
//            break;
//        }else{
//            indexTitle++;
//        }
//    }
    //移除当前的lable
    [lable removeFromSuperview];
    //删除所在的title
    [_titleArray removeObjectAtIndex:itag];
    
 
    
    //重新设置删除lable的tag值
#warning 这个逻辑想多了，第一个，i从indexTitle开始?indexTitle对应的View刚被你删掉，第一次循环是没有意义的;第二个，所有被删掉的视图后面的视图都是tag-1的操作，为什么还要加入add这种变量来绕乱观看你代码的人的思路？直接用label1.tag = label.tag - 1 不就行了？第三个,在你加入add的情况下，add从1开始，而循环里面的tag值还要减掉1，那你add从0开始不就好了，里面不就不用减1了？增加计算次数。自己改，我改直接面目全非
    //第三个 add从0开始，那么在取lable1得时候，设置还需要+1，，跟后面的-1 不是一样的次数吗
    
    NSInteger add = 1;
    
    for(int i = indexTitle+1 ; i < [_titleArray count]; i++){
        
        UILabel *lable1 = [self viewWithTag:(aTap.view.tag+add)];
        lable1.tag = lable1.tag - 1;
//        [lable1 setTag:(aTap.view.tag + add - 1 )];
        add++;
        NSLog(@"indexTitle = %d,add = %ld,tag = %ld",indexTitle,(long)add,(long)lable1.tag);
        
    }
#warning 这种调试用的代码最后注释掉
    //看所有的lable的tag跟text
//    for (int i = 100; i <([_titleArray count]+ 100); i++) {
//        UILabel *lab = [self viewWithTag:i];
//        NSLog(@"text = %@, tag =%ld ",lab.text,(long)lab.tag);
//    }

    long itagTmp = itag;
    int index = 0;
    //判断是在numberArray第几个
    for(NSNumber *j in _numArray){
        int j1 = [j intValue];
        
        NSLog(@"i = %ld ,  j1 = %d",itag,j1);
        if(itagTmp >= j1){
            itagTmp = itagTmp - j1;
            index++;
        }else{
            break;
        }

    }
    NSLog(@"index = %d",index);
#warning 这个问题上面说过了，注释不对，程序员是从0开始数数的
    //这行最后lable的tag值
    int temp = 0;
    for(NSNumber *i in _numArray){
        int i1 = [i intValue];
        if(temp <= itag){
            temp = temp + i1;
        }else{
            break;
        }
    }
    temp = temp - 1;
    NSLog(@"111这行最后的tag = %d",temp);

    
    //删除或者修改numberArray
   NSNumber *a =  _numArray[index];
    int a1 = [a intValue];
    
    if([a isEqual: @1]){
        NSLog(@"就一个");
        [_numArray removeObjectAtIndex:index];
        for(NSNumber *i in _numArray){
            NSLog(@"%@",i);
        }
    }else if((temp) == itag){
        NSLog(@"这行最后一个");
        a1 = a1 - 1;
        NSNumber *a2 = [NSNumber numberWithInt:a1];
        [_numArray replaceObjectAtIndex:index withObject:a2];
        for(NSNumber *i in _numArray){
            NSLog(@"%@",i);
        }
        lable = [self viewWithTag:aTap.view.tag];

    }else{
        
        a1 = a1 - 1;
        NSNumber *a2 = [NSNumber numberWithInt:a1];
        [_numArray replaceObjectAtIndex:index withObject:a2];
            for(NSNumber *i in _numArray){
                    NSLog(@"%@",i);
            }
        lable = [self viewWithTag:aTap.view.tag];
        [self leftMoveAnimationWithLable:lable];
    }
    //修改或者删除后的numberArray
    NSLog(@"修改或者删除后的numberArray index = %d a=%@",index,a);
    for(NSNumber * i in _numArray){
        NSLog(@"numberArray:%@",i);
    }
    


}

#warning 冗余代码注释
////单击手势
//-(void)oneTapWithTarget:(id)sender{
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneTap:)];
//    tap.numberOfTapsRequired = 1;
//    [sender addGestureRecognizer:tap];
//    
//}
//单击手势的方法
-(void)oneTap: (UITapGestureRecognizer *)sender{
#warning 这个逻辑非常有问题，你点击一个视图，为什么要去遍历所有的视图来寻找点击的视图？直接用sender.view不是就解决了吗？
   //有道理= =傻了
    UILabel *lable = (UILabel *)(sender.view);
    lable.userInteractionEnabled = NO;
    lable.textColor = [UIColor whiteColor];
    lable.backgroundColor = [UIColor redColor];
    [self.delegate passData:lable.text];
    if(_selectLable1 != nil && _selectLable2 == nil){
        _selectLable2 = lable;
    }
    if(_selectLable1 == nil){
        _selectLable1 = lable;
    }
    if(_selectLable1 != nil && _selectLable2 != nil){
//然后在这个方法内部的completeBlock里面修改两个视图的选中状态不就好了么
        [self animation:_selectLable1 button2:_selectLable2];

    }

    
//    for(int i = 100;i < (_titleArray.count + 100); i ++)
//    {
//        UILabel *lable = [self viewWithTag:i];
//        //        UIButton *button = [self viewWithTag:i];
//        if(lable == sender.view){
//            lable.userInteractionEnabled = NO;
//            lable.textColor = [UIColor whiteColor];
//            lable.backgroundColor = [UIColor redColor];
//            [self.delegate passData:lable.text];
//            if(_selectLable1 != nil && _selectLable2 == nil){
//                _selectLable2 = lable;
//            }
//            if(_selectLable1 == nil){
//                _selectLable1 = lable;
//            }
//            if(_selectLable1 != nil && _selectLable2 != nil){
//                [self animation:_selectLable1 button2:_selectLable2];
//                
//            }
//        }else{
//            lable.backgroundColor = [UIColor whiteColor];
//            lable.userInteractionEnabled = YES;
//            lable.textColor = [UIColor grayColor];
//            
//            
//        }
//    }
   

    
    
}

#pragma mark 添加按钮

-(void)createAddBtn{
    float x = 10;
    float y = 85;
    int numberCount = 0;
    for(NSString *i in _numArray){
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
        [addBtn setFrame:CGRectMake(x, y, 20, 40)];
        y = y + ButtonRowSpace;
        [addBtn setTag:(1000 + numberCount)];
        [addBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:addBtn];
        numberCount++;
    }
}



-(void)click:(UIButton *)sender{
    

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef borderColor = CGColorCreate(colorSpace, (CGFloat[]){0,1,1,1});
    long a = sender.tag - 1000;
    NSNumber *number = _numArray[a];
    
    //确定要加的lable是第几个
    int count = 0;
    int k = 0;
    for(NSNumber *j in _numArray){
        int j1 = [j intValue];
        k = k + j1;
        
        if(count == a){
            break;
        }else{
            count++;
        }
        
        
    }
    NSLog(@"k = %d",k);
    
    
    int number1 = [number intValue];
    number1 = number1 + 1;
    NSNumber *number2 = [NSNumber numberWithInt:number1];
    //修改numberArray的数值
    [_numArray replaceObjectAtIndex:a withObject:number2];
    //numberArray所有的
    for(NSNumber * i in _numArray){
        NSLog(@"numberArray:%@",i);
    }
    

    
    //修改titleArray数组
    [_titleArray insertObject:@"SJ" atIndex:k];
    
    //所有的titleArray
    for(NSNumber * i in _titleArray){
        NSLog(@"添加后的titleArray:%@",i);
    }
    
  
    
//    创建Lable
    UILabel *lableTmp = [self viewWithTag:(k-1+100)];
    NSLog(@"x= %f, y = %f",lableTmp.frame.origin.x,lableTmp.frame.origin.y);
    
        UILabel *lable =[[UILabel alloc]init];
        [lable setFrame:CGRectMake(lableTmp.frame.origin.x +  ButtonLineSpace , lableTmp.frame.origin.y
                                   ,_btnSize.width, _btnSize.height)];
        [lable.layer setMasksToBounds:YES];
        [lable.layer setCornerRadius:10.0];
        [lable.layer setBorderWidth:1.5];
        [lable.layer setBorderColor:borderColor];
        [lable setTextAlignment:NSTextAlignmentCenter];
        [lable setText:_titleArray[k]];
        [lable setTextColor:[UIColor grayColor]];
        [lable setUserInteractionEnabled:YES];
        [lable setBackgroundColor:[UIColor whiteColor]];
        [lable setTag:(_titleArray.count + 100 )];
        [self addSubview:lable];
        [self doubleTapsWithTarget:lable];
    NSLog(@"tag = %ld , text = %@",(long)lable.tag,lable.text);
    
    
    
#warning 这个逻辑太乱太复杂了，你可以像删除按钮一样，从k开始，将后面所有的label的tag+1,label.tag = label.tag +1然后直接把100+k赋值给新label的tag就可以了，这个重新写
    //修改添加lable的tag值
//    NSInteger add = 0;
//    NSUInteger titleCount = [_titleArray count];
//    NSLog(@"titleCount = %ld",titleCount);
//    for(int i = k ; i < [_titleArray count]; i++){
//       
//        UILabel *lable1 = [self viewWithTag:(100+ titleCount-1)];
//            NSLog(@"lable1.text = %@ lable1.tag = %ld",lable1.text,lable1.tag);
//        [lable1 setTag:(100 + titleCount)];
//        NSLog(@"k= %d,tag = %ld",k,(long)lable1.tag);
//        add++;
//        titleCount--;
//        if(i + 1 == [_titleArray count]){
//            UILabel *la = [self viewWithTag:(100 + _titleArray.count + 1)];
//            [la setTag:(100 + k)];
//        }
//    }
  
    

    //查看所有lable的字以及tag
    for(int i = 100; i < ([_titleArray count] + 100); i ++){
        UILabel *la = [self viewWithTag:i];
        NSLog(@"text = %@ , tag = %ld",la.text,la.tag);
    }
    
    //new修改添加lable的tag值
    for (int i = (_titleArray.count + 100 - 2); i >=(k + 100); i--) {
        UILabel *lable = [self viewWithTag:i];
        NSLog(@"%d",i);
        NSLog(@"11 lable.tag = %ld,lable.text = %@",lable.tag,lable.text);

        [lable setTag:(lable.tag + 1)];
        NSLog(@"22 lable.tag = %ld,lable.text = %@",lable.tag,lable.text);

        if(i == (k + 100)){
            UILabel *la = [self viewWithTag:(100 + _titleArray.count )];
            [la setTag:(100 + k)];
            
        }
    }
    
    
    //查看所有lable的字以及tag
    for(int i = 100; i < ([_titleArray count] + 100); i ++){
        UILabel *la = [self viewWithTag:i];
        NSLog(@"text = %@ , tag = %ld",la.text,la.tag);
    }

}


@end
