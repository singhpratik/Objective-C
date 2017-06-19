//
//  VendorViewController.h
//  Project
//
//  Created by Pratik Singh on 4/29/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface VendorViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentStatus;

- (IBAction)segmentFunction:(id)sender;

@property (strong,nonatomic) NSMutableArray *taskArray;

@property (strong,nonatomic) NSMutableArray *searchItems;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIButton *completeButton;

@property (strong,nonatomic) NSMutableArray *completedTask;
@property (strong,nonatomic) NSMutableArray  *pendingTask ;

@property (strong,nonatomic) Task *taskObj;

- (IBAction)completeButtonFunction:(id)sender;

@property (strong,nonatomic) NSMutableArray *completeList;

@end
