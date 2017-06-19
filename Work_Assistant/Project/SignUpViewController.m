//
//  SignUpViewController.m
//  Project
//
//  Created by Pratik Singh on 4/4/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "SignUpViewController.h"
#import "NSString+NSString_NSStringValidation.h"
#import "User.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initialSetup];
    self.userType =@"User";
    // Do any additional setup after loading the view
    
    //the following code adds the content size of the scroll view to that it can scroll vertically
    [_scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.2)];
  //  [_contentView setFrame:self.scrollView.frame];
}

-(void)initialSetup{
    CGRect frameRect = self.firstName.frame;
    frameRect.size.height = 45; // <-- Specify the height you want here.
    self.firstName.frame = frameRect;
    
     CGRect frameRect1 = self.lastName.frame;
    frameRect1.size.height = 45; // <-- Specify the height you want here.
    self.lastName.frame = frameRect1;
    
    CGRect frameRect2 = self.email.frame;
    frameRect2.size.height = 45; // <-- Specify the height you want here.
    self.email.frame = frameRect2;
    
    CGRect frameRect3 = self.password.frame;
    frameRect3.size.height = 45; // <-- Specify the height you want here.
    self.password.frame = frameRect3;
    
    self.password.secureTextEntry = YES;
    
    CGRect frameRect4 = self.zipCode.frame;
    frameRect4.size.height = 45; // <-- Specify the height you want here.
    self.zipCode.frame = frameRect4;
    
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

- (IBAction)signUpFunction:(id)sender {
    
    //following is used to validate at the first time
    if(([NSString isEmpty:self.firstName.text]==true)||([NSString isEmpty:self.lastName.text]==true)||([NSString isEmpty:self.email.text]==true)||([NSString isEmpty:self.password.text]==true)||([NSString isEmpty:self.zipCode.text]==true)){
        
        
  
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"All fields are Mandatory"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSString *validPassword = [NSString isValidPassword:self.password.text];
    
    if(![validPassword isEqualToString:@"valid"]){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:validPassword
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if(![NSString isValidEmail:self.email.text]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Invalid Email id"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    User *newUser = [[User alloc]init];
    //calling the method
    
    [newUser saveUserInformationWithFirstname:self.firstName.text lastName:self.lastName.text email:self.email.text password:self.password.text zipCode:self.zipCode.text signUpView:self userType:self.userType];
}


/*##############################################################################
 Method Name: resetFields
 Input:NA
 Return:NA
 Description: Following code is used to reset the fields to
 empty if the save is successfull.
##############################################################################*/

-(void)resetFields{
    self.firstName.text=@"";
    self.lastName.text=@"";
    self.zipCode.text = @"";
    self.email.text=@"";
    self.password.text=@"";
}

/*##############################################################################
 Method Name: resetFields
 Input:NA
 Return:NA
 Description: Following code is used to reset the fields to
 empty if the save is successfull.
 ##############################################################################*/

-(void)performSignInSegue{
   [self performSegueWithIdentifier:@"signedInPage" sender:self];
}

- (IBAction)userTypeFunction:(id)sender {
    self.userType = [self.userTypeSegment titleForSegmentAtIndex:[self.userTypeSegment selectedSegmentIndex]];
}
@end
