//
//  MapViewController.m
//  Project
//
//  Created by Pratik Singh on 4/28/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "MapViewController.h"
#import "Vendors.h"
#import "TableData.h"
#import "LoginViewController.h"
@import Firebase;

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout3"] style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    addButton.tintColor = [UIColor colorWithDisplayP3Red:121/255.0 green:182/255.0 blue:50/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = addButton;

    //[self loadUserLocation];
 
}


-(void)logout{
    
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
    }else{
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        LoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"loginNavigationController"];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:vc animated:YES completion:NULL];
    }
    
    
}


//
//- (void) loadUserLocation
//{
//    objLocationManager = [[CLLocationManager alloc] init];
//    objLocationManager.delegate = self;
//    objLocationManager.distanceFilter = kCLDistanceFilterNone;
//    objLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
//    if ([objLocationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        [objLocationManager requestWhenInUseAuthorization];
//    }
//    [objLocationManager startUpdatingLocation];
//}
//
//
//- (void)locationManager:(CLLocationManager *)manager
//     didUpdateLocations:(NSArray *)locations __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0)
//{
//    CLLocation *newLocation = [locations objectAtIndex:0];
//    latitude_UserLocation = newLocation.coordinate.latitude;
//    longitude_UserLocation = newLocation.coordinate.longitude;
//    [objLocationManager stopUpdatingLocation];
//    [self loadMapView];
//}
//
//
//
//- (void) loadMapView
//{
//    CLLocationCoordinate2D objCoor2D = {.latitude = latitude_UserLocation, .longitude = longitude_UserLocation};
//    MKCoordinateSpan objCoorSpan = {.latitudeDelta = 0.2, .longitudeDelta = 0.2};
//    MKCoordinateRegion objMapRegion = {objCoor2D, objCoorSpan};
//    [self.mapView setRegion:objMapRegion];
//}
//
//
//- (void)locationManager:(CLLocationManager *)manager
//       didFailWithError:(NSError *)error
//{
//    [objLocationManager stopUpdatingLocation];
//}
//

//
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    
//    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(42.3601, 71.0589);
//    
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
//    MKCoordinateRegion region = {coord, span};
//    
//    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
//    annotation.title = @"i am here";
//    [annotation setCoordinate:coord];

    
    Vendors *vendors = [[Vendors alloc]init];
    NSMutableArray *vendorList = [vendors getVendorList];
    
    for(Vendors *newVendor in vendorList){
        
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(newVendor.latitude, newVendor.longitude);
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
        // Add an annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        point.coordinate = coord;
        point.title = newVendor.vendorName;
        point.subtitle = newVendor.VendorCost;
        [self.mapView addAnnotation:point];
    }
    
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
    NSLog(@"The action is called");
    for (TableData *data in self.taskDetailsArray) {
        if([data.key isEqualToString:@"Service"]){
            data.value = view.annotation.title;
            break;
        }
    }
    self.taskObject.taskVendor = view.annotation.title;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
