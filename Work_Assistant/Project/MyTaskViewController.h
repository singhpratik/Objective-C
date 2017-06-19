//
//  MyTaskViewController.h
//  Project
//
//  Created by Pratik Singh on 4/25/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface MyTaskViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>


//The following is for the segment controll
@property (weak, nonatomic) IBOutlet UISegmentedControl *segementControl;

- (IBAction)segmentControlFunction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong,nonatomic) NSMutableArray *taskArray;

@property (strong,nonatomic) NSMutableArray *searchItems;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segementTask;

- (IBAction)segmentTaskAction:(id)sender;


@property (strong,nonatomic) Task *taskObj;

-(void)getTaskDetails:(NSString *)userId;

@property (strong,nonatomic) NSMutableArray *completedTask;
@property (strong,nonatomic) NSMutableArray *pendingTask;

@end
