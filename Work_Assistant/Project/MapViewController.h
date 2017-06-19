//
//  MapViewController.h
//  Project
//
//  Created by Pratik Singh on 4/28/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Task.h"

@interface MapViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
{

    CLLocationManager *objLocationManager;
    double latitude_UserLocation, longitude_UserLocation;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong,nonatomic) NSMutableArray *taskDetailsArray;
@property (strong,nonatomic) Task *taskObject;

@end
