//
//  DialogUtils.h
//  TresFebrero
//
//  Created by Sergio Cirasa on 2/28/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DialogUtils : NSObject

+ (void)showInternetErrorMessage:(UIViewController  *)vc handler:(void (^)(UIAlertAction *action))handler;
+ (void)showStandarErrorMessage:(UIViewController *)vc handler:(void (^)(UIAlertAction *action))handler;
+ (void)showStandarErrorMessage:(NSString*)message viewController:(UIViewController*)vc handler:(void (^)(UIAlertAction *action))handler;

@end
