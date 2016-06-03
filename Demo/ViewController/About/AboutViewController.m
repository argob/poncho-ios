//
//  AboutViewController.m
//  SlideMenuDemo
//
//  Created by Sergio Cirasa on 5/20/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property(nonatomic,weak) IBOutlet UILabel *versionLabel;
@end

@implementation AboutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Acerca de";
    [self setupVersionNumber];
}

-(void)setupVersionNumber
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    [self.versionLabel setText:[NSString stringWithFormat:@"Versión %@", version]];
}

-(IBAction)howToUseAppButtonAction:(id)sender
{

}

-(IBAction)moreAppsButtonAction:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kItunesUrl]];
}

@end
