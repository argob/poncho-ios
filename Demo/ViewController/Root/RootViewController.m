//
//  RootViewController.m
//  SlideMenuDemo
//
//  Created by Sergio Cirasa on 5/17/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "RootViewController.h"
#import "SliderMenuViewController.h"
#define kMenuAnimationDuration 0.4

@interface RootViewController ()<SliderMenuDelegate,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *menuContainer;
@property (weak, nonatomic) IBOutlet UIView *overlayShadowView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *menuWidthConstraint;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGesture;
@property(strong,nonatomic) SliderMenuViewController *menuViewController;
@property(strong,nonatomic) UIViewController *currentContentViewController;
@property(assign,nonatomic) BOOL menuAnimationInProgress;
@property(assign,nonatomic) CGFloat startDraggingPositionX;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self onFormAction];
}
//--------------------------------------------------------------------------------------------------------------------------
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark - Private Methods
-(UIBarButtonItem*)createMenuBarButtonItem
{
    UIButton *menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [menuButton setImage:[UIImage imageNamed:@"hamburgerIcon.png"] forState:UIControlStateNormal];
    menuButton.frame = CGRectMake(0, 0, 44, 44);
    menuButton.imageEdgeInsets = UIEdgeInsetsMake(0, -26, 0, 0);
    [menuButton addTarget:self action:@selector(toggleMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:menuButton];
    return leftButton;
}
//------------------------------------------------------------------------------------------------------------------------------------------
- (void)setRootContentFromStoryboard:(NSString *)name withIdentifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:name bundle:nil];
    UIViewController *root = [storyboard instantiateViewControllerWithIdentifier:identifier];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    nav.topViewController.navigationItem.leftBarButtonItem = [self createMenuBarButtonItem];
    
    [self.currentContentViewController.view removeFromSuperview];
    [self.currentContentViewController removeFromParentViewController];
    
    self.currentContentViewController = nav;
    [self addChildViewController:nav];
    [self.containerView addSubview:nav.view];
    
    nav.view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:nav.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:nav.view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:nav.view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    [self.containerView addConstraint:[NSLayoutConstraint constraintWithItem:nav.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.containerView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
}
//------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark - SliderMenuDelegate
- (void)onFormAction
{
    [self setRootContentFromStoryboard:@"Main" withIdentifier:@"FormViewController"];
    [self performSelector:@selector(closeMenu) withObject:nil afterDelay:0];
}

- (void)onListAction
{
    [self setRootContentFromStoryboard:@"Main" withIdentifier:@"ListViewController"];
    [self performSelector:@selector(closeMenu) withObject:nil afterDelay:0];
}

- (void)onGridAction
{
    [self setRootContentFromStoryboard:@"Main" withIdentifier:@"GridViewController"];
    [self performSelector:@selector(closeMenu) withObject:nil afterDelay:0];
}

- (void)onAboutAction
{
    [self setRootContentFromStoryboard:@"Main" withIdentifier:@"AboutViewController"];
    [self performSelector:@selector(closeMenu) withObject:nil afterDelay:0];
}
//------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark - Segue Methods
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SliderMenu"]) {
        self.menuViewController = segue.destinationViewController;
        self.menuViewController.delegate = self;
    }
}
//------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark - Menu Methods
-(BOOL)isMenuOpen
{
    if(self.menuWidthConstraint.constant == self.leftMargin.constant)
        return YES;
    else return NO;
}

-(void)toggleMenu
{
    if(self.menuAnimationInProgress)
        return;
    
    if([self isMenuOpen]){
        [self closeMenu];
    }else{
        [self openMenu];
    }
}

-(void)openMenu
{
    self.menuAnimationInProgress = YES;
    self.leftMargin.constant = self.menuWidthConstraint.constant;
    self.overlayShadowView.alpha = 0.0;
    self.overlayShadowView.hidden = NO;
    [UIView animateWithDuration:kMenuAnimationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.overlayShadowView.alpha = 1.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished){
        self.menuAnimationInProgress = NO;
        self.tapGesture.enabled = YES;
    }];
}

-(void)closeMenu
{
    self.menuAnimationInProgress = YES;
    self.leftMargin.constant = 0;
    [UIView animateWithDuration:kMenuAnimationDuration delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.overlayShadowView.alpha = 0.0;
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished){
        self.overlayShadowView.hidden = YES;
        self.menuAnimationInProgress = NO;
        self.tapGesture.enabled = NO;
    }];
}
//------------------------------------------------------------------------------------------------------------------------------------------
-(CGFloat)animationDurationForDistance:(CGFloat)dist
{
    return (dist*kMenuAnimationDuration) / self.menuWidthConstraint.constant;
}
//------------------------------------------------------------------------------------------------------------------------------------------
#pragma mark - Gesture Recognizer Methods
- (IBAction)onPanRecognized:(UIPanGestureRecognizer *)gesture
{
    if(self.menuAnimationInProgress)
        return;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.startDraggingPositionX = self.leftMargin.constant;
        
    }else if (gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint translation = [gesture translationInView:self.view];
        if(self.startDraggingPositionX + translation.x < 0)
            self.leftMargin.constant = 0;
        else if (self.startDraggingPositionX + translation.x>self.menuWidthConstraint.constant)
            self.leftMargin.constant = self.menuWidthConstraint.constant;
        else self.leftMargin.constant = self.startDraggingPositionX + translation.x;
                
    }else if (gesture.state == UIGestureRecognizerStateEnded) {
        CGPoint gestureVelocity = [gesture velocityInView:self.view];
        CGPoint translation = [gesture translationInView:self.view];
        CGFloat xx = self.startDraggingPositionX + translation.x;
        CGFloat dist = 0;
        self.menuAnimationInProgress = YES;
        
        if(xx >= self.menuWidthConstraint.constant *0.5 && gestureVelocity.x > 0){
            dist = self.menuWidthConstraint.constant - self.leftMargin.constant;
            self.leftMargin.constant = self.menuWidthConstraint.constant;
        }else if((xx < self.menuWidthConstraint.constant *0.5 && gestureVelocity.x > 0) || (xx < self.menuWidthConstraint.constant * 0.75 && gestureVelocity.x < 0)){
            dist = self.leftMargin.constant;
            self.leftMargin.constant = 0;
        }else{
            dist = self.menuWidthConstraint.constant - self.leftMargin.constant;
            self.leftMargin.constant = self.menuWidthConstraint.constant;
        }
        
        [UIView animateWithDuration:[self animationDurationForDistance:dist] delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionCurveEaseOut animations:^{
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished){
            self.menuAnimationInProgress = NO;
            self.tapGesture.enabled = [self isMenuOpen];
        }];
    }
}

- (IBAction)onTapRecognized:(UITapGestureRecognizer *)sender
{
    if(self.menuAnimationInProgress)
        return;
    
    if([self isMenuOpen]){
        [self closeMenu];
    }
}
//------------------------------------------------------------------------------------------------------------------------------------------

@end
