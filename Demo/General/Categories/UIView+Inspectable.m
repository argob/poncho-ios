//
//  UIView+Inspectable.m
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "UIView+Inspectable.h"

@implementation UIView(Inspectable)

-(void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

-(CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

-(void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

-(CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

-(void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

-(UIColor*)borderColor
{
    return [[UIColor alloc] initWithCGColor:self.layer.borderColor];
}

@end
