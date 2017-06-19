//
//  User.m
//  Project
//
//  Created by Pratik Singh on 4/7/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "SignUpViewController.h"
#import "LoginPageViewController.h"
@import Firebase;

@implementation User

-(void)saveUserInformationWithFirstname:(NSString *)fName lastName:(NSString *)lName email:(NSString *)email password:(NSString *)password zipCode:(NSString *)zipCode signUpView:(SignUpViewController *)signUpViewController userType:(NSString *)userType{

   // NSError *error = Ni;
    //check if email already exists
    [[FIRAuth auth]
     createUserWithEmail:email
     password:password
     completion:^(FIRUser *_Nullable user,
                  NSError *_Nullable error) {
         
         if(!error){
             NSLog(@"######   User created successfully %@  ######### /n",user.uid);
             self.dbRef = [[FIRDatabase database]reference];
             [[[self.dbRef child:@"users"] child:[user.uid description]]
                      setValue:@{@"firstName":fName,
                                 @"lastName":lName,
                                 @"email":email,
                                 @"zipCode":zipCode,
                                 @"userType":userType,
                                 @"userId":user.uid}];
            
             [self showUIAlertMessage:@"Data saved successfully" title:@"Success"];
             
             [signUpViewController resetFields];
             // [signUpViewController performSignInSegue];
             
             
         }else{
             [self showUIAlertMessage:[[NSString alloc]initWithString:[error localizedDescription]] title:@"Error"];
         }
     }];
}

-(void)showUIAlertMessage:(NSString *)message title:(NSString *)title{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
}

-(User *)signInUser:(NSString *)emailAddress password:(NSString *)password loginPageController:(LoginPageViewController *)loginPageController{
    
    User *user  = [[User alloc]init];
    [[FIRAuth auth] signInWithEmail:emailAddress
                           password:password
                         completion:^(FIRUser *user, NSError *error) {
                             
                             if(!error){
                                 
                                 //following code is used to get the users and check if its user or vendor
                                    //      #############
                                 
                                 FIRDatabaseReference *ref;
                                 ref = [[FIRDatabase database] reference];
                                 
                                 [[[[ref child:@"users"] queryOrderedByChild:@"userId"]
                                   queryEqualToValue:user.uid]
                                  observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                                   
                                      if (snapshot.value != [NSNull null]){
                                          
                                          for (NSDictionary *snap in [snapshot.value allValues]) {
                                              User *user = [[User alloc]init];
                                              user.userId = [snap objectForKey:@"userType"];
                                              
                                              if([user.userId isEqualToString:@"User"]){
                                              
                                                   [loginPageController loadSignInPage];
                                              }else{
                                                  
                                                  [loginPageController loadVendorSignInPage];
                                                  NSLog(@"different user");
                                              }
                                              
                                          }
                                      }
                              
                                  }];

                                 
                                 
                                 //########################
                                 
                                 
                                 NSLog(@"user logged in");
                                
                             }else{
                                 [self showUIAlertMessage:[[NSString alloc]initWithString:[error localizedDescription]] title:@"Error"];
                                 
                                  NSLog(@"%@",error);
                             }
                             
                         }];
    return user;
}

@end
