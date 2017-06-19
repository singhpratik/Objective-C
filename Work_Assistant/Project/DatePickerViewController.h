//
//  DatePickerViewController.h
//  Project
//
//  Created by Pratik Singh on 4/24/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface DatePickerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIDatePicker *datePick;
@property (strong,nonatomic) NSMutableArray *taskDetailsArray;
@property (weak, nonatomic) IBOutlet UIButton *selectDateButton;
@property (strong,nonatomic) Task *taskObject;


- (IBAction)selectDateFunction:(id)sender;



@end
