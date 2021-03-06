//
//  LYWelcomVC.m
//  CuiHuXiangShan
//
//  Created by 李悦东 on 16/7/15.
//  Copyright © 2016年 fengdikeji. All rights reserved.
//

#import "LYWelcomVC.h"
#import <iCarousel.h>

#import "LYTabBarVC.h"

@interface LYWelcomVC ()<iCarouselDataSource,iCarouselDelegate>

@property (nonatomic, strong)NSArray *imageList;

@end

@implementation LYWelcomVC

#pragma mark -lazy
- (NSArray *)imageList{
    if (!_imageList) {
        _imageList = @[@"welcome01",@"welcome02",@"welcome03"];
    }
    return _imageList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    iCarousel *carousel = [[iCarousel alloc]initWithFrame:[UIScreen mainScreen].bounds];
    carousel.type = iCarouselTypeLinear;
    carousel.dataSource = self;
    carousel.delegate = self;
    carousel.bounces = NO;
    carousel.pagingEnabled = YES;
    [self.view addSubview:carousel];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = YES;
}


#pragma mark -dataSource
- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel{
    return self.imageList.count;
}

- (UIView*)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view {
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    imageView.image = [UIImage imageNamed:self.imageList[index]];
    
    //最后一张图加入立即进入按钮
    if (index == self.imageList.count - 1) {
        UIImageView *enterBtnView = [self enterViewWithImageView:imageView];
        enterBtnView.userInteractionEnabled = YES;
        imageView.userInteractionEnabled = YES;
        [enterBtnView bk_whenTapped:^{ //点击立即进入按钮图
            //进入主界面
            [self.navigationController pushViewController:[LYTabBarVC new] animated:YES];
        }];
    }
    return imageView;
}

- (UIImageView*)enterViewWithImageView:(UIImageView*)imageView{
    UIImageView *enterBtnView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"enter"]];
    [imageView addSubview:enterBtnView];
    enterBtnView.center = self.view.center;
    enterBtnView.y = self.view.height - 100;
    
    return enterBtnView;
}


@end
