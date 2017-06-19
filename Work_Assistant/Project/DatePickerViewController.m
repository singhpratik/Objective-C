//
//  DatePickerViewController.m
//  Project
//
//  Created by Pratik Singh on 4/24/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "DatePickerViewController.h"
#import "TableData.h"
#import "LoginViewController.h"
@import Firebase;

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

- (IBAction)selectDateFunction:(id)sender {
    
    NSDate *dateChosen = [self.datePick date];
    NSString *dateString  = [[NSString alloc]initWithFormat:@"%@",dateChosen];
    NSLog(@"%@",dateString);
    
    for (TableData *data in self.taskDetailsArray) {
        if([data.key isEqualToString:@"When"]){
            data.value = dateString;
            break;
        }
    }
    
    self.taskObject.taskDate = dateString;
    [self.navigationController popViewControllerAnimated:YES];
 
    
}
@end
