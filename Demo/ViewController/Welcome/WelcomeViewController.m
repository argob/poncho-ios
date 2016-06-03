//
//  WelcomeViewController.m
//  SlideMenuDemo
//
//  Created by Sergio Cirasa on 5/20/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController () <UIScrollViewDelegate>
@property(nonatomic,weak) IBOutlet UIButton *startButton;
@property(nonatomic,weak) IBOutlet UIButton *leftButton;
@property(nonatomic,weak) IBOutlet UIButton *rightButton;
@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel *descriptionLabel;
@property(nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property(nonatomic,weak) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Welcome";
    self.startButton.hidden = self.navigationController!=nil;
    self.leftButton.enabled = NO;
    
    if(self.navigationController!=nil){
        self.startButton.hidden = YES;
        self.contentHeight.constant = self.contentHeight.constant - self.startButton.frameHeight;
    }
}
//--------------------------------------------------------------------------------------------------------------------------
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return (self.navigationController==nil)?UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
}
//--------------------------------------------------------------------------------------------------------
-(void)showContent
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        weakSelf.titleLabel.alpha = 1.0;
        weakSelf.descriptionLabel.alpha = 1.0;
    } completion:^(BOOL finished){     }];
}

-(void)hideContent
{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        weakSelf.titleLabel.alpha = 0.0;
        weakSelf.descriptionLabel.alpha = 0.0;
    } completion:^(BOOL finished){     }];
}
//--------------------------------------------------------------------------------------------------------
#pragma mark - Button Actions
-(IBAction)leftButtonAction:(id)sender
{
    [self hideContent];
    if(self.pageControl.currentPage>0){
        [self.scrollView setContentOffset:CGPointMake((self.pageControl.currentPage-1) * self.scrollView.frameWidth, 0) animated:YES];
    }
}
//--------------------------------------------------------------------------------------------------------
-(IBAction)rightButtonAction:(id)sender
{
    [self hideContent];
    if(self.pageControl.currentPage < self.pageControl.numberOfPages -1){
        [self.scrollView setContentOffset:CGPointMake((self.pageControl.currentPage+1) * self.scrollView.frameWidth, 0) animated:YES];
    }
}
//--------------------------------------------------------------------------------------------------------
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.pageControl.currentPage =  self.scrollView.contentOffset.x / self.scrollView.frameWidth;
    self.leftButton.enabled = YES;
    self.rightButton.enabled = YES;
    if(self.pageControl.currentPage==0)
        self.leftButton.enabled = NO;
    else if(self.pageControl.currentPage == self.pageControl.numberOfPages-1)
        self.rightButton.enabled = NO;
    
    [self showContent];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hideContent];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{

}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{

}
//--------------------------------------------------------------------------------------------------------
@end
