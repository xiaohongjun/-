//
//  ViewController.m
//  喜马拉雅
//
//  Created by xhj on 15-1-5.
//  Copyright (c) 2015年 xhj. All rights reserved.
//

#import "ViewController.h"
//#import "BannerDelegate.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (weak, nonatomic) IBOutlet UIScrollView *banner;
@property (weak, nonatomic) IBOutlet UIImageView *bannerImage;
@property(strong,nonatomic)  UIPageControl*pageControl;
@property (strong,nonatomic) NSTimer * mtimer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//控件的frame都是相对于其父控件的。
    CGFloat contentH=CGRectGetMaxY(self.bottomButton.frame)+10+CGRectGetMaxY(self.banner.frame);
    self.scrollView.contentSize=CGSizeMake(0, contentH);
    self.scrollView.contentInset=UIEdgeInsetsMake(0, 0, 40, 0);
//    self.scrollView.contentOffset=CGPointMake(0, -64);
//    self.scrollView.delegate=self;
    self.bannerDelegate=[[BannerDelegate alloc] init];
    self.banner.delegate=self;
    
    CGFloat bannerW=CGRectGetWidth(self.bannerImage.frame);
    CGFloat bannerH=CGRectGetHeight(self.bannerImage.frame);
    
    for(int i=0;i<5;i++)
    {
        UIImageView*imageView=[[UIImageView alloc] init];
        NSString*picName=[[NSString alloc] initWithFormat:@"img_0%d",i+1];
        imageView.image=[UIImage imageNamed:picName];
        imageView.frame=CGRectMake(bannerW*i, 0, bannerW, bannerH);
        [self.banner addSubview:imageView];
        
        
        
    }
    self.banner.contentSize=CGSizeMake(5*bannerW,0);
    self.banner.showsHorizontalScrollIndicator=NO;
    self.banner.pagingEnabled=YES;
    CGRect rect=CGRectMake(140, 140, 60, 20);
   self.pageControl=[[UIPageControl alloc] initWithFrame:(rect)];
    self.pageControl.numberOfPages=5;
    self.pageControl.currentPage=0;
    self.pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    self.pageControl.pageIndicatorTintColor=[UIColor blueColor];
    [self.view addSubview:self.pageControl];
   
    
}

-(void)nextImage
{
    CGFloat scrollW = self.banner.frame.size.width;
    NSUInteger pageNumber = self.pageControl.currentPage;
    if(pageNumber == [self.banner subviews].count)
    {
        pageNumber = 0;
    }
//    self.banner contentOffset
    CGPoint point = CGPointMake(scrollW * (pageNumber + 1), 0);
    [self.banner setContentOffset:point];
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"--------ScrollView正在滚动");
    CGFloat scrollW=self.banner.frame.size.width;
    int  page = ([self.banner contentOffset].x+scrollW*0.5)/scrollW;
    if (page == 5) {
        page =0;
    }

    self.pageControl.currentPage=page;
    
}



-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"--------scrollView将要滚动");
}




-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
     NSLog(@"--------scrollView停止滚动");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidDisappear:(BOOL)animated
{
    [_mtimer invalidate];
}

-(void)viewDidAppear:(BOOL)animated
{
     _mtimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}


@end
