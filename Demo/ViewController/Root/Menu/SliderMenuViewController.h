//
//  SlideMenuViewController.h
//  SlideMenuDemo
//
//  Created by Sergio Cirasa on 5/17/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SliderMenuDelegate <NSObject>
- (void)onFormAction;
- (void)onListAction;
- (void)onGridAction;
- (void)onAboutAction;
@end

@interface SliderMenuViewController : UIViewController
@property (weak, nonatomic) id<SliderMenuDelegate> delegate;
@end
