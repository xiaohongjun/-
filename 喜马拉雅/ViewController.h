//
//  ViewController.h
//  喜马拉雅
//
//  Created by xhj on 15-1-5.
//  Copyright (c) 2015年 xhj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BannerDelegate.h"
@interface ViewController : UIViewController<UIScrollViewDelegate,UIPageViewControllerDelegate>

@property(strong,nonatomic)BannerDelegate*bannerDelegate;
@end

