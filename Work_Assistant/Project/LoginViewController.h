//
//  LoginViewController.h
//  Project
//
//  Created by Pratik Singh on 4/4/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALayer+CALayer_XibConfiguration_h.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController<FBSDKLoginButtonDelegate>

//labels for the page
@property (weak, nonatomic) IBOutlet UILabel *assistantLabel;
@property (weak, nonatomic) IBOutlet UILabel *workLabel;
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

- (IBAction)facebookLoginAction:(id)sender;

- (void)loginButton;

@end
