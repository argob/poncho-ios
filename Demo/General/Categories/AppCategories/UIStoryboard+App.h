//
//  UIStoryboard+App.h
//  Demo
//
//  Created by Sergio Cirasa on 6/1/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"

@interface UIStoryboard(App)

+ (UIStoryboard *)mainStoryboard;
+ (UIViewController *)instantiateRootViewController;
+ (DetailViewController *)instantiateDetailViewController;

@end
