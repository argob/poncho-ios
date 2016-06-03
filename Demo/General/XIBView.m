//
//  XIBView.m
//  TresFebrero
//
//  Created by Sergio Cirasa on 2/19/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

#import "XIBView.h"

@interface XIBView ()

@property (weak, nonatomic) IBOutlet UIView *view;

@end

@implementation XIBView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
        return self;
    }
    return nil;
}

- (void)initialize {
    [self setupFromXib];
}

- (void)setupFromXib {
    if (!self.view) {
        NSString *className = NSStringFromClass(self.class);
        self.view = [[[NSBundle bundleForClass:self.class] loadNibNamed:className owner:self options:nil] firstObject];
        [self addSubview:self.view];
        
        [self.view setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSDictionary *views = NSDictionaryOfVariableBindings(_view);
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_view]|" options:0 metrics:nil views:views]];
        [self addConstraints: [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_view]|" options:0 metrics:nil views:views]];
    }
}

@end
