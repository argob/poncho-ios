//
//  UIView+FrameHelp.h
//
//  Created by Sergio Cirasa on 01/12/13.
//  Copyright (c) 2013 Creative Coefficient. All rights reserved.
//

#import <UIKit/UIKit.h>

#define LogFrame(s,v)   (NSLog(@"%@ --> x: %f  y: %f  width: %f  height: %f",s,v.frame.origin.x,v.frame.origin.y,v.frame.size.width,v.frame.size.height))

#define LogFrameX(v)   (NSLog(@"x: %f",v.frame.origin.x))
#define LogFrameY(v)   (NSLog(@"y: %f",v.frame.origin.y))
#define LogFrameWidth(v)   (NSLog(@"width: %f",v.frame.size.width))
#define LogFrameHeight(v)   (NSLog(@"height: %f",v.frame.size.height))

#define LogFrameSize(v)   (NSLog(@"width: %f  height: %f",v.frame.size.width,v.frame.size.height))
#define LogFrameOrigin(v)   (NSLog(@"x: %f  y: %f",v.frame.origin.x,v.frame.origin.y))
#define LogFrameCenter(v)   (NSLog(@"cx: %f  cy: %f",v.center.x,v.center.y))

@interface UIView(FrameHelp)

@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGSize frameSize;

@property (nonatomic) CGFloat frameX;
@property (nonatomic) CGFloat frameY;

@property (nonatomic) CGFloat frameWidth;
@property (nonatomic) CGFloat frameHeight;

@property (nonatomic) CGFloat frameRight; // x + width
@property (nonatomic) CGFloat frameBottom; // y + height


- (CGSize)boundingBoxSize;
- (void)setFrameWithBoundingBoxSizeAndOrigin:(CGPoint)origin;

- (CGFloat)midXWithWidth:(CGFloat)width;
- (CGFloat)midYWithHeight:(CGFloat)height;
- (CGSize)midOriginWithSize:(CGSize)size;

- (void)setFrameMidX:(CGFloat)originY :(CGFloat)width :(CGFloat)height;
- (void)setFrameMidY:(CGFloat)originX :(CGFloat)width :(CGFloat)height;
- (void)setFrameMidOrigin:(CGFloat)width :(CGFloat)height;
- (void)setFrameMidOrigin:(CGSize)size;
- (void)LogFrame;

@end
