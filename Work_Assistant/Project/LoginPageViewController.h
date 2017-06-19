//
//  LoginPageViewController.h
//  Project
//
//  Created by Pratik Singh on 4/13/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginPageViewController : UIViewController<UITextViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)loginButtonFunction:(id)sender;


//following is used for the image corousel
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong,nonatomic) NSMutableArray *imageArray;
@property (nonatomic) int currentIndex;
@property (nonatomic) NSTimer *timerObj;

-(void)loadVendorSignInPage;


//loading signin page
-(void)loadSignInPage;


@end
