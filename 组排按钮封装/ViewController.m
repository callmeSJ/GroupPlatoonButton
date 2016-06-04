//
//  ViewController.m
//  组排按钮封装
//
//  Created by SJ on 16/5/25.
//  Copyright © 2016年 SJ. All rights reserved.
//



#import "ViewController.h"
#import "View.h"
@interface ViewController ()


@property (nonatomic, strong) View *VView;
@property (nonatomic, strong) UILabel *lable1;
@property (nonatomic, strong) UILabel *lable2;

@end

@implementation ViewController


#warning 残留的warning解决以后的新任务
-(void)newMissions{
//1、增加功能：点击一个按钮被选中后，点击第二个按钮选中后和第一个被选中的按钮以动画的形式互换位置，换完之后将两个按钮的选中取消
    /**
     *  最简单的动画方法
     *
     *  @param NSTimeInterval 动画完成需要的时间，单位秒
     *
     *  @return 无
     */
    [UIView animateWithDuration:0.5 animations:^{
        //动画即将完成时的视图状态
    } completion:^(BOOL finished) {
        //动画完成后需要执行的代码块
    }];

//2.增加功能：按钮双击删除，并且被删除的按钮如果在右边还有按钮，将右边的按钮向左移填补空缺，同时修改View内部的排版数组，删除该按钮在标题数组中对应的标题，双击响应状态UIControlEventTouchDownRepeat
    
//3.增加功能：在每一行排阻按钮的最左边增加一个显示加号的按钮，当我点击加号按钮时，该按钮对应行最右边增加一个按钮，标题随意，同时修改View内部的排版数组，并将标题添加到标题数组的对应位置中
    
}

//析构方法，对象被释放的时候会调用这个方法

-(void)dealloc{
    //name参数可以不写是因为直接删除了观察者，self被删除后无论他观察了多少变量都无所谓了
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ChangeNameNotification:) name:@"name" object:nil];
   
    

    [self createView];
    

    [self initLable];
    
    
    
    //index来设置初始选中状态
//    [_VView choseOneButton:4];
    //取消用户交互
//    [_VView cancelButtonInteraction];
//    [self getFrame];
    
}


#pragma mark 创建Lable
-(void)initLable{
    _lable1 = [[UILabel alloc]initWithFrame:CGRectMake(50, 25, 80, 40)];
    _lable2 = [[UILabel alloc]initWithFrame:CGRectMake(200, 25, 80, 40)];
    [_lable1 setText:@"1"];
    [_lable2 setText:@"2"];
    [self.view addSubview:_lable1];
    [self.view addSubview:_lable2];

}
#pragma mark 初始化数组数组

#pragma mark 创建视图
-(void)createView{
    NSMutableArray *numberArray = [[NSMutableArray alloc]initWithObjects:@3,@2,@1,@2,@1, nil];
    NSMutableArray *titleArray = [[NSMutableArray alloc]init];
    [titleArray addObject:@"白金卡"];
    [titleArray addObject:@"银卡"];
    [titleArray addObject:@"金卡"];
    [titleArray addObject:@"灰卡"];
    [titleArray addObject:@"黑卡"];
    [titleArray addObject:@"钻石卡"];
    [titleArray addObject:@"白卡"];
    [titleArray addObject:@"红卡"];
    [titleArray addObject:@"绿卡"];
    
    CGSize buttonSize = CGSizeMake(60, 30);
    _VView = [[View alloc]init];
    _VView.btnSize = buttonSize;
    _VView.titleArray = titleArray;
    _VView.numArray = numberArray;
    CGSize size = [_VView getViewSize];
    _VView.frame = CGRectMake(0, 0, size.width, size.height);
//    [_VView autoFrame:_numberArray :buttonSize];
////    _VView = [[View alloc]initWithFrame:CGRectMake(0, 0, 320, 500)];
//    [_VView createButton:_numberArray :_titleArray :buttonSize];
     _VView.backgroundColor = [UIColor whiteColor];
    //是我傻
    _VView.delegate = self;
    [self.view addSubview:_VView];
   

}

#pragma mark 实现代理方法
//代理的传值
-(void)passData:(NSString *)str{
    self.lable1.text = str;
    self.lable2.text = str;
    self.lable2.backgroundColor = [UIColor purpleColor];
    self.lable2.textColor = [UIColor whiteColor];
}


//通知的传值
-(void)ChangeNameNotification:(NSNotification*)notification{
    
    NSDictionary *nameDictionary = [notification userInfo];
    
    self.lable1.text = [nameDictionary objectForKey:@'t'];
    self.lable2.text = [nameDictionary objectForKey:@'t'];
    self.lable2.backgroundColor = [UIColor purpleColor];
    self.lable2.textColor = [UIColor whiteColor];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
