//
//  SignedInViewController.m
//  Project
//
//  Created by Pratik Singh on 4/7/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "SignedInViewController.h"
#import "MoverViewController.h"
#import "TableData.h"
#import "MoverViewController.h"
#import "Task.h"
#import "MoverViewController.h"
#import "LoginViewController.h"


@import Firebase;

@interface SignedInViewController ()

@end

@implementation SignedInViewController

- (void)viewDidLoad {
      [super viewDidLoad];
        [self initialize];
    
      //adding + button
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout3"] style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
   addButton.tintColor = [UIColor colorWithDisplayP3Red:121/255.0 green:182/255.0 blue:50/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = addButton;
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

-(void)initialize{

    //gesture reccognition for movers
    UITapGestureRecognizer *singleFingerTapMover =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    
    [self.moverView addGestureRecognizer:singleFingerTapMover];
    
    UITapGestureRecognizer *singleFingerTapCleaning =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapCleaning:)];
    
    [self.cleaningView addGestureRecognizer:singleFingerTapCleaning];
    
    UITapGestureRecognizer *singleFingerTapHandyMan =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapHandyMan:)];
    
    [self.handmanView addGestureRecognizer:singleFingerTapHandyMan];
    
    UITapGestureRecognizer *singleFingerTapGeneralWork =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTapGeneralWork:)];
    
    [self.generalHelp addGestureRecognizer:singleFingerTapGeneralWork];
    
    // [self.view addGestureRecognizer:singleFingerTap];
  
    self.handyManImageView.image=[UIImage imageNamed:@"furnitureTools"];
    self.cleaningImageView.image = [UIImage imageNamed:@"cleaning01"];
    self.generalHelpImageView.image = [UIImage imageNamed:@"generalHelp01"];
    self.moverImageView.image = [UIImage imageNamed:@"box01"];

}


- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer
{
    self.taskName =@"Moving and Packing";
    [self performSegueWithIdentifier:@"testing" sender:self];
}

- (void)handleSingleTapCleaning:(UITapGestureRecognizer *)recognizer
{
    self.taskName =@"House Cleaning";
    [self performSegueWithIdentifier:@"testing" sender:self];
}

- (void)handleSingleTapGeneralWork:(UITapGestureRecognizer *)recognizer
{
    self.taskName =@"General Assistance";
    [self performSegueWithIdentifier:@"testing" sender:self];
}


- (void)handleSingleTapHandyMan:(UITapGestureRecognizer *)recognizer
{
    self.taskName =@"Furniture Repair";
    [self performSegueWithIdentifier:@"testing" sender:self];
}




- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // [START auth_listener]
                [[FIRAuth auth]
                   addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
                       NSLog(@"The user id is %@ and email is %@",user.uid,user.email);
                   }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    //the following is for mover class
    Task *taskObject = [[Task alloc]init];
    [Task initialiseAll:taskObject];
    taskObject.taskType = self.taskName;
    NSMutableArray *tableArray = [[NSMutableArray alloc]init];
    TableData *tableDataTaskAdd = [[TableData alloc]init];
    tableDataTaskAdd.key = @"Start Address";
    [tableArray addObject:tableDataTaskAdd];
    
    TableData *tableDataTaskEnd= [[TableData alloc]init];
    tableDataTaskEnd.key = @"Destination Address";
    [tableArray addObject:tableDataTaskEnd];
    
    TableData *tableDataTime= [[TableData alloc]init];
    tableDataTime.key = @"When";
    [tableArray addObject:tableDataTime];
    
    TableData *tableDataVehicle= [[TableData alloc]init];
    tableDataVehicle.key = @"Vehicle required";
    [tableArray addObject:tableDataVehicle];
    
    TableData *taskDataDetail= [[TableData alloc]init];
    taskDataDetail.key = @"Task Details";
    [tableArray addObject:taskDataDetail];
    
    TableData *taskService= [[TableData alloc]init];
    taskService.key = @"Service";
    [tableArray addObject:taskService];
    MoverViewController *viewController  = segue.destinationViewController;
    viewController.taskDetailsArray = tableArray;
    viewController.taskObject = taskObject;
    
    
}




@end
