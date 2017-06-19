//
//  LoginPageViewController.m
//  Project
//
//  Created by Pratik Singh on 4/13/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "LoginPageViewController.h"
#import "NSString+NSString_NSStringValidation.h"
#import "User.h"
#import "SignedInViewController.h"
#import "VendorViewController.h"




@interface LoginPageViewController ()

@end

@implementation LoginPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeImage];
}


//following code is used to initialise the image
-(void)initializeImage{
    
    self.navigationController.navigationBar.translucent = YES;
   
    CGRect frameRect = self.username.frame;
    frameRect.size.height = 45; // <-- Specify the height you want here.
    self.username.frame = frameRect;
    
    CGRect frameRect1= self.password.frame;
    frameRect1.size.height = 45; // <-- Specify the height you want here.
    self.password.frame = frameRect1;
    
   self.password.secureTextEntry = YES;
    
    self.imageArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    UIImage *image01 = [UIImage imageNamed:@"furnitureRepair"];
    [self.imageArray addObject:image01];
    UIImage *image02 =[UIImage imageNamed:@"groceShopping"];
    [self.imageArray addObject:image02];
    UIImage *image03 =[UIImage imageNamed:@"officeMover01"];
    [self.imageArray addObject:image03];
    UIImage *image04 =[UIImage imageNamed:@"plumber01"];
    [self.imageArray addObject:image04];
    self.imageView.image = image01;
    self.currentIndex=0;
    self.timerObj =[NSTimer scheduledTimerWithTimeInterval:5.0f target:self selector:@selector(imageSlidShow) userInfo:nil repeats:YES];

}

-(void)imageSlidShow{

    int numberOfImages = [self.imageArray count];
    self.currentIndex++;
    if(self.currentIndex>=numberOfImages){
        self.currentIndex=0;
    }

    
    UIImage *currentView = [self.imageArray objectAtIndex:self.currentIndex];
    
    [UIView transitionWithView:self.imageView duration:2.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        self.imageView.image = currentView;
    } completion:^(BOOL finished) {
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation
// /In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//    
//}

-(void)loadSignInPage{
    
    UITabBarController *MW = [UITabBarController alloc];
//SignedInViewController *MW = [SignedInViewController alloc];
MW = [self.storyboard instantiateViewControllerWithIdentifier:@"singinTab"];
[self presentViewController:MW animated:YES completion:^{
}];
}

-(void)loadVendorSignInPage{
    
    VendorViewController *MW = [VendorViewController alloc];
    //SignedInViewController *MW = [SignedInViewController alloc];
    MW = [self.storyboard instantiateViewControllerWithIdentifier:@"vendorPage"];
    [self.navigationController pushViewController:MW animated:YES];
//    [self presentViewController:MW animated:YES completion:^{
//    }];
}


- (IBAction)loginButtonFunction:(id)sender {
    //remove code later
   // [self loadSignInPage];
    
    //check if the user name or password is empty
    if(([NSString isEmpty:self.username.text]==true)||([NSString isEmpty:self.password.text]==true)){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Username and Password cannot be empty"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    

    User *user = [[User alloc]init];
    user = [user signInUser:self.username.text password:self.password.text loginPageController:self];
    
}

//#### following is the code for declaring the delegate method

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    return YES;
}


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
    
    [self.view endEditing:YES];
    return YES;
}

- (void)keyboardDidShow:(NSNotification *)notification
{
    // Assign new frame to your view
    [self.view setFrame:CGRectMake(0,-200,self.view.bounds.size.width,self.view.bounds.size.height+100)]; //here taken -110 for example i.e. your view will be scrolled to -110. change its value according to your requirement.
}

-(void)keyboardDidHide:(NSNotification *)notification
{
     [self.view setFrame:CGRectMake(0,0,self.view.bounds.size.width,self.view.bounds.size.height)];
}


@end
