//
//  TaskDetailsViewController.h
//  Project
//
//  Created by Pratik Singh on 4/24/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface TaskDetailsViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextView *taskDetails;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

//instance of task object
@property(strong,nonatomic) Task *taskObject;

//instance of task array
@property (strong,nonatomic) NSMutableArray *taskDetailsArray;

@property (weak, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)addButtonFunction:(id)sender;

@end
