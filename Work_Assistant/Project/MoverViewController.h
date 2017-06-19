//
//  MoverViewController.h
//  Project
//
//  Created by Pratik Singh on 4/14/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "User.h"
#import <GooglePlaces/GooglePlaces.h>

@interface MoverViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,GMSAutocompleteViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *taskDetailsArray;
@property (strong,nonatomic) Task *taskObject;
@property (strong,nonatomic) User *currentUser;

@property (weak, nonatomic) IBOutlet UIButton *addTaskButton;

- (IBAction)addTaskFunction:(id)sender;

@property  int flag;



-(void)initialiseTaskDetails;
@end
