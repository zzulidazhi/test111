//
//  ViewController.m
//  LunBoTu
//
//  Created by 张永治 on 15/7/31.
//  Copyright (c) 2015年 张永治. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIScrollViewDelegate>

{
    NSInteger _index;
    NSInteger oldIndex;
}
@property(nonatomic,strong)UIScrollView   *scorllView;
@property(nonatomic,strong)NSArray        *picArray;
@property(nonatomic,strong)NSMutableArray *viewArray;
@property(nonatomic,strong)UIImageView    *otherImageView;
@end

@implementation ViewController

-(void)initSomething
{
    _index =1;
    oldIndex = _index;
    _picArray = [NSArray arrayWithObjects:@"111.jpg",@"222.jpg",@"333.jpg",@"444.jpg",@"555.jpg",@"666.jpg",@"777.jpg",@"888.jpg",@"999.jpg", nil];
    
    _viewArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    _otherImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    [self initSomething];
    
    _scorllView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64)];
    _scorllView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height-64);
    _scorllView.pagingEnabled = YES;
    _scorllView.showsHorizontalScrollIndicator = NO;
    _scorllView.showsVerticalScrollIndicator = NO;
    _scorllView.delegate = self;
    _scorllView.contentOffset = CGPointMake(320, 0);
    
    [self.view addSubview:_scorllView];
    
    
    
    for (int i=0; i<3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_viewArray addObject:imageView];
        [_scorllView addSubview:imageView];
    }
    
    
    [self loadPicImageViewWithIndex:_index];
    
    // Do any additional setup after loading the view, typically from a nib.
}



-(void)loadPicImageViewWithIndex:(NSInteger)index
{

    
    for (int i=0; i<[_viewArray count]; i++) {
        
        UIImageView *imageView = _viewArray[i];
        imageView.frame =CGRectMake(self.view.frame.size.width*i, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        int imageIndex = (_index+i)%[_picArray count];
        
        NSLog(@"iamge:%d",imageIndex);
        
        UIImage *image = [UIImage imageNamed:_picArray[imageIndex]];
        imageView.image = image;
        
        if (nil ==imageView.superview) {
            
            CGRect frame = _scorllView.frame;
            frame.origin.x = _scorllView.frame.size.width *i;
            imageView.frame = frame;
            
            [_scorllView addSubview:imageView];
        }
        
    }
    
    
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x <=0) {
        
        
        _index --;
        
        [self loadPicImageViewWithIndex:_index];
        
        [scrollView setContentOffset:CGPointMake(320,0)];
        
    }
    
    if (scrollView.contentOffset.x >=2*320) {
        
        
        _index ++;
        
        [self loadPicImageViewWithIndex:_index];
        
        [scrollView setContentOffset:CGPointMake(320,0)];
        
    }
    

}


//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"end dragging");
//    
//    float offsetX = scrollView.contentOffset.x-self.view.frame.size.width;
//    
//    //向左滑动,右边图片显示出来
//    if ( offsetX>0) {
//        
//        if (offsetX>=self.view.frame.size.width/2) {
//            NSLog(@"左滑超过一半");
//            
//            [self loadPicImageViewWithIndex:_index+1];
//        }
//        
//        if (offsetX<self.view.frame.size.width/2) {
//            NSLog(@"左滑小于一半");
//        }
//        
//    }
//    
//    //向右滑动，左边图片出来
//    if (offsetX <0) {
//        
//        if (-offsetX>self.view.frame.size.width/2) {
//            
//            NSLog(@"右滑超过一半");
//            
//            [self loadPicImageViewWithIndex:_index-1];
//        }
//        else
//        {
//            NSLog(@"右滑小于一半");
//        }
//    }
//
//}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"contendoffset:%@",NSStringFromCGPoint(scrollView.contentOffset));

    
    if (_index == 0) {
        
        _index = 0;
        
    }
    
    [scrollView setContentOffset:CGPointMake(320,0)animated:YES];
    

}


//-(void)loadPicWithIndex:(NSInteger)index With


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
