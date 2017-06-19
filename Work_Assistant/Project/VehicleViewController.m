//
//  VehicleViewController.m
//  Project
//
//  Created by Pratik Singh on 4/24/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "VehicleViewController.h"
#import "TableData.h"
#import "LoginViewController.h"
@import Firebase;

@interface VehicleViewController ()

@end

@implementation VehicleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialise];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout3"] style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    addButton.tintColor = [UIColor colorWithDisplayP3Red:121/255.0 green:182/255.0 blue:50/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = addButton;
    //initialising the screen
    
    // Do any additional setup after loading the view.
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


-(void)initialise{
    UIImage *image01 = [UIImage imageNamed:@"car"];
    self.imageView.image = image01;
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


- (IBAction)selectButtonFunction:(id)sender {
    
       NSString *title = [self.segment titleForSegmentAtIndex:[self.segment selectedSegmentIndex]];
    
    if([title isEqualToString:@"light"]){
        self.imageView.image = [UIImage imageNamed:@"car"];
        self.taskObject.taskVehicleReq =@"car";
    }else if([title isEqualToString:@"medium"]){
        self.imageView.image = [UIImage imageNamed:@"truck"];
          self.taskObject.taskVehicleReq =@"truck";
    }else if([title isEqualToString:@"heavy"]){
        self.imageView.image = [UIImage imageNamed:@"van"];
          self.taskObject.taskVehicleReq =@"van";
    }
    
    for (TableData *data in self.taskDetailsArray) {
        if([data.key isEqualToString:@"Vehicle required"]){
            data.value = self.taskObject.taskVehicleReq;
            break;
        }
    }
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)segementFunction:(id)sender {
    
    NSString *title = [self.segment titleForSegmentAtIndex:[self.segment selectedSegmentIndex]];
    
    if([title isEqualToString:@"light"]){
         self.imageView.image = [UIImage imageNamed:@"car"];
    }else if([title isEqualToString:@"medium"]){
        self.imageView.image = [UIImage imageNamed:@"truck"];
    }else if([title isEqualToString:@"heavy"]){
         self.imageView.image = [UIImage imageNamed:@"van"];
    }
    
}
@end
