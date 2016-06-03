//
//  UIView+Inspectable.h
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Inspectable)
@property(nonatomic,assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic,assign) IBInspectable CGFloat borderWidth;
@property(nonatomic,strong) IBInspectable UIColor *borderColor;
@end
