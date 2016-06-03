//
//  UIView+FrameHelp.m
//
//  Created by Sergio Cirasa on 01/12/13.
//  Copyright (c) 2013 Creative Coefficient. All rights reserved.
//

#import "UIView+FrameHelp.h"

@implementation UIView(FrameHelp)

#pragma mark - Frame
//-----------------------------------------------------------------------------------------------------------------------------
- (CGPoint)frameOrigin 
{
	return self.frame.origin;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameOrigin:(CGPoint)origin 
{
	self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (CGSize)frameSize 
{
	return self.frame.size;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameSize:(CGSize)size 
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (CGFloat)frameX 
{
	return self.frame.origin.x;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameX:(CGFloat)x 
{
	self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (CGFloat)frameY 
{
	return self.frame.origin.y;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameY:(CGFloat)y 
{
	self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (CGFloat)frameWidth 
{
	return self.frame.size.width;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameWidth:(CGFloat)width 
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (CGFloat)frameHeight 
{
	return self.frame.size.height;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameHeight:(CGFloat)height 
{
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (CGFloat)frameRight 
{
	return self.frame.origin.x + self.frame.size.width;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameRight:(CGFloat)right 
{
	self.frame = CGRectMake(right - self.frame.size.width, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (CGFloat)frameBottom 
{
	return self.frame.origin.y + self.frame.size.height;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameBottom:(CGFloat)bottom 
{
	self.frame = CGRectMake(self.frame.origin.x, bottom - self.frame.size.height, self.frame.size.width, self.frame.size.height);
}
//-----------------------------------------------------------------------------------------------------------------------------
#pragma mark - Bounding Box
- (CGSize)boundingBoxSize
{
    CGFloat t_width = 0;
    CGFloat t_height = 0;
    
    for (UIView *t_view in self.subviews) {
        if ((t_view.frame.origin.x + t_view.frame.size.width) > t_width) 
            t_width = t_view.frame.origin.x + t_view.frame.size.width;
        if ((t_view.frame.origin.y + t_view.frame.size.height) > t_height) 
            t_height = t_view.frame.origin.y + t_view.frame.size.height;
    }
    
    return CGSizeMake(t_width, t_height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameWithBoundingBoxSizeAndOrigin:(CGPoint)origin
{
    CGSize t_size = [self boundingBoxSize];
    self.frame = CGRectMake(origin.x, origin.y, t_size.width, t_size.height);
}
//-----------------------------------------------------------------------------------------------------------------------------
#pragma mark - Positioning
- (CGFloat)midXWithWidth:(CGFloat)width
{
    return (self.frame.size.width - width) / 2.0;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (CGFloat)midYWithHeight:(CGFloat)height
{
    return (self.frame.size.height - height) / 2.0;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (CGSize)midOriginWithSize:(CGSize)size
{
    return CGSizeMake([self midXWithWidth:size.width], [self midYWithHeight:size.height]);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameMidX:(CGFloat)originY :(CGFloat)width :(CGFloat)height
{
    self.frame = CGRectMake([self midXWithWidth:width], originY, width, height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameMidY:(CGFloat)originX :(CGFloat)width :(CGFloat)height
{
    self.frame = CGRectMake(originX, [self midYWithHeight:height], width, height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameMidOrigin:(CGFloat)width :(CGFloat)height
{
    self.frame = CGRectMake([self midXWithWidth:width], [self midYWithHeight:height], width, height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)setFrameMidOrigin:(CGSize)size
{
    self.frame = CGRectMake([self midXWithWidth:size.width], [self midYWithHeight:size.height], size.width, size.height);
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)LogFrame
{
    NSLog(@"x: %f  y: %f  width: %f  height: %f",self.frameX,self.frameY,self.frameWidth,self.frameHeight);
}
//-----------------------------------------------------------------------------------------------------------------------------

@end
