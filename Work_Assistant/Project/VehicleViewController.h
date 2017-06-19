//
//  VehicleViewController.h
//  Project
//
//  Created by Pratik Singh on 4/24/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface VehicleViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)segementFunction:(id)sender;
//below code is for image corousel
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
- (IBAction)selectButtonFunction:(id)sender;

//instance of task object
@property(strong,nonatomic) Task *taskObject;

//instance of taskdetails array
@property (strong,nonatomic) NSMutableArray *taskDetailsArray;



@end
