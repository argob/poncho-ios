//
//  BaseViewController.m
//  TresFebrero
//
//  Created by Sergio Cirasa on 2/10/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self customizeNavigationBar];
}
//--------------------------------------------------------------------------------------------------------------------------
-(void)viewWillAppear:(BOOL)animated
{
    if(self.navigationItem.backBarButtonItem!=nil)
        self.navigationItem.backBarButtonItem.title = @"";
}
//--------------------------------------------------------------------------------------------------------------------------
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskPortrait|UIInterfaceOrientationMaskPortraitUpsideDown);
}
//--------------------------------------------------------------------------------------------------------------------------
- (BOOL)shouldAutorotate
{
    return NO;
}
//--------------------------------------------------------------------------------------------------------------------------
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//--------------------------------------------------------------------------------------------------------------------------
- (void)customizeNavigationBar {
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setImage:[UIImage imageNamed:@"backButton.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(onReturnAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(0, 0, 60, 44);
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}
//--------------------------------------------------------------------------------------------------------------------------
#pragma mark - IBAction Methods
- (IBAction)onReturnAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
//--------------------------------------------------------------------------------------------------------------------------
@end
