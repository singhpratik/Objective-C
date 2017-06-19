//
//  User.h
//  Project
//
//  Created by Pratik Singh on 4/7/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

//Imports
@import FirebaseDatabase;
#import "SignUpViewController.h"
#import "LoginPageViewController.h"

//Interface
@interface User : NSObject

@property (strong,nonatomic) NSString *firstName;
@property (strong,nonatomic) NSString *lastName;
@property (strong,nonatomic) NSString *email;
@property (strong,nonatomic) NSString *password;
@property (strong,nonatomic) NSString *zipCode;
@property (strong,nonatomic) NSString *userId;
@property (strong,nonatomic) NSString *userType;

//reference to the database
@property (strong, nonatomic) FIRDatabaseReference *dbRef;

//following function is used to save the user information to the database (Fire Base)
-(void)saveUserInformationWithFirstname:(NSString *)fName lastName:(NSString *)lName email:(NSString *)email password:(NSString *)password zipCode:(NSString *)zipCode signUpView:(SignUpViewController *)signUpViewController userType:(NSString *)userType;

-(User *)signInUser:(NSString *)emailAddress password:(NSString *)password loginPageController:(LoginPageViewController *)loginPageController;

@end

