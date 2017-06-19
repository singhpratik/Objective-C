//
//  LoginViewController.m
//  Project
//
//  Created by Pratik Singh on 4/4/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@import Firebase;


@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initialSetup];
    //setting the height of the text field
    
    
}


-(void)initialSetup{
    
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] initWithFrame:self.facebookLoginButton.frame];
    loginButton.readPermissions = @[@"email"];
    loginButton.delegate = self;
    //  loginButton.center = self.view.center;
    [self.view addSubview:loginButton];
    //  self.facebookLoginButton = loginButton;
    UINavigationBar *bar = [self.navigationController navigationBar];
    // [bar setTintColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0]];
    [bar setBackgroundColor:[UIColor colorWithRed:121 green:182 blue:50 alpha:0]];

}

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    if (error == nil) {
        FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                         .tokenString];
        
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                      // ...
                                      if (error) {
                                          // ...
                                          NSLog(@"error in credentials");
                                          return;
                                      }else{
                                          
                                          UITabBarController *MW = [UITabBarController alloc];
                                          //SignedInViewController *MW = [SignedInViewController alloc];
                                          MW = [self.storyboard instantiateViewControllerWithIdentifier:@"singinTab"];
                                          [self presentViewController:MW animated:YES completion:^{
                                          }];
                                          
                                          
                                      }
                                  }];
        
        
    } else {
        NSLog(@"The error while loggin in is %@",[error localizedDescription]);
    }
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{

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

- (IBAction)facebookLoginAction:(id)sender {
    
}

@end
