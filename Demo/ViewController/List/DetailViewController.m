//
//  DetailViewController.m
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "DetailViewController.h"
#import "ParallaxHeaderView.h"

@interface DetailViewController () <UIScrollViewDelegate>
@property(nonatomic,weak) IBOutlet UIView *imageContainer;
@property(nonatomic,weak) IBOutlet UIImageView *imageView;
@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel *descriptionLabel;
@property(nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong) ParallaxHeaderView *headerView;
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.province.title;
    self.titleLabel.text = self.province.title;
    self.descriptionLabel.text = self.province.provinceDescription;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.province.bannerUrl]];
    
    self.headerView = [ParallaxHeaderView parallaxHeaderViewWithImageUrl:self.province.bannerUrl forSize:CGSizeMake(self.view.frameWidth, self.view.frameWidth / 2.0)];
    self.headerView.headerTitleLabel.text = self.province.title;
    [self.imageContainer addSubview:self.headerView];
    
    [self addShareButtonToNavigation];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self.headerView refreshBlurViewForNewImage];
    [super viewDidAppear:animated];
}

- (void)addShareButtonToNavigation {
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setImage:[UIImage imageNamed:@"share.png"] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(0, 0, 60, 44);
    cancelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
    self.navigationItem.rightBarButtonItem = leftButton;
}

#pragma mark - UISCrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.headerView layoutHeaderViewForScrollViewOffset:scrollView.contentOffset];
}

#pragma mark - Button Action
-(IBAction)shareButtonAction:(id)sender
{
    NSString *str = self.province.title;
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:@[self,str] applicationActivities:nil];
    NSArray *excludedActivities = @[UIActivityTypePrint, UIActivityTypeCopyToPasteboard,
                                    UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll,
                                    UIActivityTypeAddToReadingList,UIActivityTypeAirDrop];
    
    controller.excludedActivityTypes = excludedActivities;
    [controller setValue:self.province.title forKey:@"subject"];
    
    [self.navigationController presentViewController:controller animated:YES completion:nil];
}

@end
