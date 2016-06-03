//
//  LocationPickerViewController.h
//  TresFebrero
//
//  Created by Sergio Cirasa on 2/22/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


@protocol LocationPickerDelegate <NSObject>
-(void)didSelect:(CLLocationCoordinate2D)coord address:(NSString*)address;
-(void)didCancelLocationPicker;
@end

@interface LocationPickerViewController : BaseViewController
@property(nonatomic,weak)id<LocationPickerDelegate> delegate;
@end
