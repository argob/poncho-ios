//
//  Created by Sergio Cirasa Development on 1/20/11.
//  Copyright 2010 Creative Coefficient, All rights reserved.
//

#import "LoaderView.h"

@interface LoaderView(private)
- (void)showView;
@end

@implementation LoaderView

LoaderView *loaderViewInstance;
//------------------------------------------------------------------------------------------------------------------------------------------------------------
+ (id)sharedLoader{
	if (!loaderViewInstance){
        UIApplication* thisApplication = [UIApplication sharedApplication]; 
        UIWindow* frontWindow = thisApplication.keyWindow;
		loaderViewInstance = [[LoaderView alloc]initWithFrame:frontWindow.frame];           
    }   
    
	return loaderViewInstance;
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
- (id)initWithFrame:(CGRect)frame {
	if ((self = [super initWithFrame:frame])) {

		activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((frame.size.width-24)/2, (frame.size.height-24)/2, 24, 24)];
		activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhite;
		[self addSubview:activityIndicator];
		isShow=FALSE;
        cantCalls=0;
        blockingHidden=FALSE;
        
		loadingLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, activityIndicator.frame.size.height+activityIndicator.frame.origin.y+5, 320, 30)];
		loadingLabel.backgroundColor = [UIColor clearColor];
		loadingLabel.textColor = [UIColor whiteColor];
		loadingLabel.font = [UIFont systemFontOfSize:24];
		loadingLabel.textAlignment = NSTextAlignmentCenter;
        
		loadingLabel.text=@"";
        
        [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
        [[NSNotificationCenter defaultCenter] addObserver: self selector: @selector(receivedRotate:) name: UIDeviceOrientationDidChangeNotification object: nil];
		
		self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
		[self addSubview:loadingLabel];
    }
    return self;
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)showView{
   	UIApplication* thisApplication = [UIApplication sharedApplication]; 
    UIWindow* frontWindow = thisApplication.keyWindow;
    [activityIndicator startAnimating];
    isShow=TRUE;
	[frontWindow addSubview:self];
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
-(void) receivedRotate: (NSNotification*) notification{
    
    if(isShow && !loadingLabel.hidden){
        UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
        
        if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft){
            loadingLabel.transform= CGAffineTransformMakeRotation(3* M_PI / 2);
            loadingLabel.frame = CGRectMake(activityIndicator.frame.origin.x+30,(self.frame.size.height-loadingLabel.frame.size.height)/2, loadingLabel.frame.size.width, loadingLabel.frame.size.height);
            
        }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
            loadingLabel.transform= CGAffineTransformMakeRotation( -3*M_PI / 2);
            loadingLabel.frame = CGRectMake(activityIndicator.frame.origin.x-30,(self.frame.size.height-loadingLabel.frame.size.height)/2, loadingLabel.frame.size.width, loadingLabel.frame.size.height);
            
        }else if(interfaceOrientation==UIInterfaceOrientationPortrait){
            loadingLabel.transform= CGAffineTransformIdentity;
            loadingLabel.frame = CGRectMake((self.frame.size.width-loadingLabel.frame.size.width)/2, activityIndicator.frame.origin.y+30, loadingLabel.frame.size.width, loadingLabel.frame.size.height);
        }else if(interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown){
            loadingLabel.transform= CGAffineTransformMakeRotation( M_PI);
            loadingLabel.frame = CGRectMake((self.frame.size.width-loadingLabel.frame.size.width)/2, activityIndicator.frame.origin.y-30, loadingLabel.frame.size.width, loadingLabel.frame.size.height);
        }        
    }	
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
//Show improvement view
- (void)show {	
	loadingLabel.text=@"";
    [self showView];
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)showWithMessage:(NSString*) msg{
	loadingLabel.text=msg;
    
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(interfaceOrientation==UIInterfaceOrientationLandscapeLeft){
        loadingLabel.transform= CGAffineTransformMakeRotation(3* M_PI / 2);
        loadingLabel.frame = CGRectMake(activityIndicator.frame.origin.x+30,(self.frame.size.height-loadingLabel.frame.size.height)/2, loadingLabel.frame.size.width, loadingLabel.frame.size.height);
        
    }else if(interfaceOrientation==UIInterfaceOrientationLandscapeRight){
        loadingLabel.transform= CGAffineTransformMakeRotation( -3*M_PI / 2);
        loadingLabel.frame = CGRectMake(activityIndicator.frame.origin.x-30,(self.frame.size.height-loadingLabel.frame.size.height)/2, loadingLabel.frame.size.width, loadingLabel.frame.size.height);
        
    }else if(interfaceOrientation==UIInterfaceOrientationPortrait){
        loadingLabel.transform= CGAffineTransformIdentity;
        loadingLabel.frame = CGRectMake((self.frame.size.width-loadingLabel.frame.size.width)/2, activityIndicator.frame.origin.y+30, loadingLabel.frame.size.width, loadingLabel.frame.size.height);
        
    }else if(interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown){
        loadingLabel.transform= CGAffineTransformMakeRotation( M_PI);
        loadingLabel.frame = CGRectMake((self.frame.size.width-loadingLabel.frame.size.width)/2, activityIndicator.frame.origin.y-30, loadingLabel.frame.size.width, loadingLabel.frame.size.height);
    }

	[self showView];
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)showAndAccumulation{
    blockingHidden=YES;
    cantCalls++;
    [self show];
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)showAndAccumulationWithMessage:(NSString*) msg{
    blockingHidden=YES;
    cantCalls++;
    [self showWithMessage:msg];
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
//Hide improvement view
- (void)hide {
    if(!blockingHidden){
        isShow=FALSE;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [activityIndicator stopAnimating];
        [self removeFromSuperview];
    }
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)hideAndDecumulated{
    cantCalls--;    
    if(blockingHidden &&  cantCalls<=0){
        blockingHidden=FALSE;
        cantCalls=0;
        [self hide];
    }
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)cancelBlocking{
    blockingHidden=FALSE;
    cantCalls=0;
    [self hide];
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
- (void)dealloc {    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}
//------------------------------------------------------------------------------------------------------------------------------------------------------------
@end
