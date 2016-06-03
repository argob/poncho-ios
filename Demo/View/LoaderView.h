//
//  LoaderView.h
//  InomaxNicu
//
//  Created by EV2 Development on 1/20/11.
//  Copyright 2010 Eveo, All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoaderView : UIView {
	UILabel* loadingLabel;
	UIActivityIndicatorView *activityIndicator;
    BOOL isShow;
    int cantCalls;
    BOOL blockingHidden;
}

+ (id)sharedLoader;

- (void)show;
- (void)showWithMessage:(NSString*) msg;


- (void)showAndAccumulation;
- (void)showAndAccumulationWithMessage:(NSString*) msg;

- (void)hide;
- (void)hideAndDecumulated;

- (void)cancelBlocking;

@end