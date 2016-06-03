//
//  LocationPickerViewController.m
//  TresFebrero
//
//  Created by Sergio Cirasa on 2/22/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

#import "LocationPickerViewController.h"
#import "LoaderView.h"

@interface LocationPickerViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,UISearchBarDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, weak) IBOutlet MKMapView *mapView;
@property(nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property(nonatomic, assign) CLLocationCoordinate2D chosenLocation;
@property(nonatomic,assign) BOOL firstTime;
@property (strong, nonatomic) MKPointAnnotation *annotation;
@end

@implementation LocationPickerViewController

//-----------------------------------------------------------------------------
#pragma mark - Life Cycle Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstTime = YES;
    
    [self.mapView setMapType:MKMapTypeStandard];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading];
    [self.mapView setZoomEnabled:YES];
    [self.mapView setScrollEnabled:YES];
    self.mapView.userInteractionEnabled = YES;
    
    [self restartMapPosition];
    self.locationManager = [[CLLocationManager alloc] init] ;
    self.locationManager.delegate = self;
    [self startToTrackUserLocation];
    [self draw3FPolygon];
    
    self.annotation = [[MKPointAnnotation alloc] init];
    [self putAnnotationinCoord:CLLocationCoordinate2DMake(-34.601340, -58.572190)];
}
//-----------------------------------------------------------------------------
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[[UIApplication sharedApplication] keyWindow] makeToast:@"Presione y arrastre el pin para seleccionar otra ubicación." image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
}
//-----------------------------------------------------------------------------
#pragma mark - Button Actions
-(IBAction)cancelButtonAction:(id)sender
{
    [self.delegate didCancelLocationPicker];
    [self dismissViewControllerAnimated:YES completion:^{}];
}
//-----------------------------------------------------------------------------
-(IBAction)selectButtonAction:(id)sender
{
    [[LoaderView sharedLoader] show];
    self.chosenLocation = self.mapView.centerCoordinate;
    [self reverseGeocode:self.chosenLocation];
    
    if(self.delegate)
        [self.delegate didSelect:self.chosenLocation address:self.searchBar.text];
}
//-----------------------------------------------------------------------------
#pragma mark - Private Methods
-(void)startToTrackUserLocation
{
    if (CLLocationManager.authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.mapView.showsUserLocation = YES;
    } else if(CLLocationManager.authorizationStatus == kCLAuthorizationStatusDenied) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Demo app necesita conocer su ubicación actual"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Aceptar"
                                                              style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
                                                              
                                                              }];
        [alert addAction:firstAction];

        UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Cancelar"
                                                               style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
                                                                   
                                                               }];        
        [alert addAction:secondAction];
        
        [self presentViewController:alert animated:YES completion:nil];
    } else{
        [self.locationManager requestWhenInUseAuthorization];
    }
}
//-----------------------------------------------------------------------------
-(void)restartMapPosition
{
    MKCoordinateRegion buenosAiresCoordinateRegion = MKCoordinateRegionMake(CLLocationCoordinate2DMake(-34.601340, -58.572190), MKCoordinateSpanMake(0.20, 0.20));
    [self.mapView setRegion:buenosAiresCoordinateRegion animated:YES];
}
//---------------------------------------------------------------------------------------------------------------------
-(void)putAnnotationinCoord:(CLLocationCoordinate2D) coordinate
{
    MKCoordinateRegion region = {{0.0, 0.0 }, { 0.0, 0.0 } };
    region.center.latitude = coordinate.latitude;
    region.center.longitude = coordinate.longitude;
    region.span.longitudeDelta = 0.008f;
    region.span.longitudeDelta = 0.008f;
    [self.mapView setRegion:region animated:YES];
    [self.annotation setCoordinate:coordinate];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView addAnnotation:self.annotation];
}
//---------------------------------------------------------------------------------------------------------------------
-(NSString*)parseAddress:(CLPlacemark*)addressPlacmark
{
    NSString *address = @"";
    if(addressPlacmark.locality)
        address = [NSString stringWithFormat:@"%@",addressPlacmark.locality];
    
    if(addressPlacmark.thoroughfare)
        address = [NSString stringWithFormat:@"%@, %@",address,addressPlacmark.thoroughfare];
    
    if(addressPlacmark.subLocality)
        address = [NSString stringWithFormat:@"%@, %@",address,addressPlacmark.subLocality];
    
    if(addressPlacmark.subThoroughfare)
        address = [NSString stringWithFormat:@"%@, %@",address,addressPlacmark.subThoroughfare];

    return address;
}
//---------------------------------------------------------------------------------------------------------------------
- (void)reverseGeocode:(CLLocationCoordinate2D)locationCord{
    
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    CLLocation *location = [[CLLocation alloc] initWithLatitude:locationCord.latitude longitude:locationCord.longitude];

    __weak typeof(self) weakSelf = self;
    [geo reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *addressPlacmark = [placemarks firstObject];
        NSString *address = [self parseAddress:addressPlacmark];
        [[LoaderView sharedLoader] hide];
        weakSelf.searchBar.text = address;
    }];
}
//-----------------------------------------------------------------------------
-(void)draw3FPolygon
{
    CLLocationCoordinate2D  points[12];
    points[0] = CLLocationCoordinate2DMake(-34.547469, -58.617932);
    points[1] = CLLocationCoordinate2DMake(-34.563006, -58.646244);
    points[2] = CLLocationCoordinate2DMake(-34.568890, -58.639206);
    points[3] = CLLocationCoordinate2DMake(-34.607993, -58.592893);
    points[4] = CLLocationCoordinate2DMake(-34.606059, -58.588870);
    points[5] = CLLocationCoordinate2DMake(-34.628743, -58.572300);
    points[6] = CLLocationCoordinate2DMake(-34.625909, -58.566807);
    points[7] = CLLocationCoordinate2DMake(-34.654309, -58.529226);
    points[8] = CLLocationCoordinate2DMake(-34.616004, -58.530920);
    points[9] = CLLocationCoordinate2DMake(-34.597512, -58.522702);
    points[10] = CLLocationCoordinate2DMake(-34.591235, -58.562025);
    points[11] = CLLocationCoordinate2DMake(-34.547469, -58.617932);
    
    MKPolygon *poly = [MKPolygon polygonWithCoordinates:points count:12];
    [self.mapView addOverlay:poly];
}
//----------------------------------------------------------------------------------------------------------------------
-(void)dropAnnotationView:(MKAnnotationView *)aV{
    CGRect endFrame = aV.frame;
    aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - 20, aV.frame.size.width, aV.frame.size.height);
    
    // Animate drop
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        aV.frame = endFrame;
        // Animate squash
    }completion:^(BOOL finished){
        if (finished) {
            [UIView animateWithDuration:0.05 animations:^{
                aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
                
            }completion:^(BOOL finished){
                [UIView animateWithDuration:0.1 animations:^{
                    aV.transform = CGAffineTransformIdentity;
                }];
            }];
        }
    }];
}
//----------------------------------------------------------------------------------------------------------------------
-(void)dragAnnotationView:(MKAnnotationView *)aV{
    [UIView animateWithDuration:0.05 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - 10, aV.frame.size.width, aV.frame.size.height);
    }completion:^(BOOL finished){
    }];
}
//----------------------------------------------------------------------------------------------------------------------
#pragma mark - MKMapViewDelegate
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id < MKAnnotation >)annotation {

    if ([annotation isKindOfClass:[MKUserLocation class]]){
        ((MKUserLocation *)annotation).title = @"";
        return nil;
    }

    static NSString *identifier = @"Pin";
    MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
    if (annotationView){
        annotationView.annotation = annotation;
    }else{
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
    }
    
    annotationView.draggable = YES;

    [annotationView setCanShowCallout:NO];
    annotationView.image = [UIImage imageNamed:@"pinViolet.png"];
    return annotationView;
    
}
//----------------------------------------------------------------------------------------------------------------------
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)annotationView didChangeDragState:(MKAnnotationViewDragState)newState fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateStarting) {
        annotationView.dragState = MKAnnotationViewDragStateDragging;
        [self dragAnnotationView:annotationView];
        self.searchBar.text = @"";
    }
    else if (newState == MKAnnotationViewDragStateEnding || newState == MKAnnotationViewDragStateCanceling) {
        annotationView.dragState = MKAnnotationViewDragStateNone;
        [self dropAnnotationView:annotationView];
        [self reverseGeocode:self.annotation.coordinate];
    }
}
//----------------------------------------------------------------------------------------------------------------------
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolygon class]]){
        MKPolygonRenderer *aView = [[MKPolygonRenderer alloc] initWithPolygon:overlay];
        aView.fillColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:0.2];
        aView.strokeColor = [UIColor colorWithRed:244.0/255.0 green:129.0/255.0 blue:31.0/255.0 alpha:1];
        aView.lineWidth = 3;
        return aView;
    }
    return nil;
}
//----------------------------------------------------------------------------------------------------------------------
- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    
    for (aV in views) {
        
        // Don't pin drop if annotation is user location
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        // Check if current annotation is inside visible map rect, else go to next one
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point)) {
            continue;
        }
        
        CGRect endFrame = aV.frame;
        
        // Move annotation out of view
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
        
        // Animate drop
        [UIView animateWithDuration:0.5 delay:0.04*[views indexOfObject:aV] options:UIViewAnimationOptionCurveLinear animations:^{
            
            aV.frame = endFrame;
            
            // Animate squash
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
                    
                }completion:^(BOOL finished){
                    [UIView animateWithDuration:0.1 animations:^{
                        aV.transform = CGAffineTransformIdentity;
                    }];
                }];
            }
        }];
    }
}
//---------------------------------------------------------------------------------------------------------------------
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    if(self.firstTime){
        if(self.mapView.userLocation  && CLLocationCoordinate2DIsValid(self.mapView.userLocation.coordinate) && self.mapView.userLocation.coordinate.latitude!=0){
            [self putAnnotationinCoord:self.mapView.userLocation.coordinate];
            [self reverseGeocode:self.mapView.userLocation.coordinate];
            self.firstTime = NO;
        }
    }
}
//---------------------------------------------------------------------------------------------------------------------
#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        self.mapView.showsUserLocation = YES;
    }
}
//---------------------------------------------------------------------------------------------------------------------
#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;
{
    [searchBar resignFirstResponder];
}
//---------------------------------------------------------------------------------------------------------------------
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    if(searchBar.text.length==3)
        return;
    
    [[LoaderView sharedLoader] show];
    CLGeocoder *geo = [[CLGeocoder alloc] init];
    CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(-34.601340, -58.572190) radius:14000 identifier:@"3F"];
    [geo geocodeAddressString:searchBar.text inRegion:region completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *addressPlacmark = [placemarks firstObject];
        //NSString *address = [self parseAddress:addressPlacmark];
        [self putAnnotationinCoord:addressPlacmark.location.coordinate];
        [[LoaderView sharedLoader] hide];
    }];
}
//---------------------------------------------------------------------------------------------------------------------


@end
