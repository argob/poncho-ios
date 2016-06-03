//
//  DialogUtils.m
//  TresFebrero
//
//  Created by Sergio Cirasa on 2/28/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

#import "DialogUtils.h"

@implementation DialogUtils

//--------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showInternetErrorMessage:(UIViewController*)vc handler:(void (^)(UIAlertAction *action))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error de conexión. Compruebe su conexión a internet e intentenlo nuevamente."
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault handler:handler];
    
    [alert addAction:firstAction];
    [vc presentViewController:alert animated:YES completion:nil];
}
//--------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showStandarErrorMessage:(UIViewController*)vc handler:(void (^)(UIAlertAction *action))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error inesperado. intente nuevamente."
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault handler:handler];
    
    [alert addAction:firstAction];
    [vc presentViewController:alert animated:YES completion:nil];
}
//--------------------------------------------------------------------------------------------------------------------------------------------
+ (void)showStandarErrorMessage:(NSString*)message viewController:(UIViewController*)vc handler:(void (^)(UIAlertAction *action))handler
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error inesperado. intente nuevamente."
                                                                   message:nil
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDefault handler:handler];
    
    [alert addAction:firstAction];
    [vc presentViewController:alert animated:YES completion:nil];
}
//--------------------------------------------------------------------------------------------------------------------------------------------
@end
