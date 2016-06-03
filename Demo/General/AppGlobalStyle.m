//
//  AppGlobalStyle.m
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "AppGlobalStyle.h"

@implementation AppGlobalStyle

+(void)applyGlobalStyle
{
    [[UINavigationBar appearance] setBarTintColor:[UIColor appBlueColor]];
    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,nil]];
}

@end
