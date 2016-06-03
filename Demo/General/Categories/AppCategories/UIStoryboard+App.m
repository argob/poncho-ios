//
//  UIStoryboard+App.m
//  Demo
//
//  Created by Sergio Cirasa on 6/1/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "UIStoryboard+App.h"

@implementation UIStoryboard(App)

+ (UIStoryboard *)mainStoryboard
{
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

+ (UIViewController *)instantiateRootViewController
{
    UIStoryboard *storyboard = [UIStoryboard mainStoryboard];
    return [storyboard instantiateViewControllerWithIdentifier:@"RootViewController"];
}

+ (DetailViewController *)instantiateDetailViewController
{
    UIStoryboard *storyboard = [UIStoryboard mainStoryboard];
    return [storyboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
}


@end
