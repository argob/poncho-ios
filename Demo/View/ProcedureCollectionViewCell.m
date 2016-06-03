//
//  ProcedureCollectionViewCell.m
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "ProcedureCollectionViewCell.h"

@interface ProcedureCollectionViewCell ()
@property(nonatomic,weak) IBOutlet UIView *containerView;
@end

@implementation ProcedureCollectionViewCell

-(void)awakeFromNib
{
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.shadowOpacity = 0.4;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
}

-(void) setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    self.containerView.backgroundColor = highlighted ? [UIColor appBlueColor] : [UIColor clearColor];
    [self setNeedsDisplay];
}

@end
