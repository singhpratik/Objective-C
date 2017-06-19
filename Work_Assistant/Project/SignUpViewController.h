//
//  SignUpViewController.h
//  Project
//
//  Created by Pratik Singh on 4/4/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController<UIAlertViewDelegate>

//following is used to scroll when the key board pops up
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *userTypeSegment;

- (IBAction)userTypeFunction:(id)sender;

@property (strong,nonatomic) NSString *userType;

//following are used to take the text input
@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *zipCode;

//following is the signup button
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

//following is the function on click of the button Sign Up
- (IBAction)signUpFunction:(id)sender;

//following function is used to reset the fields
-(void)resetFields;

//following function is used to perform the segue
-(void)performSignInSegue;

@end
