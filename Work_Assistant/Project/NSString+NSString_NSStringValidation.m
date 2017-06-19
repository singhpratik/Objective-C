//
//  NSString+NSString_NSStringValidation.m
//  Project
//
//  Created by Pratik Singh on 4/8/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "NSString+NSString_NSStringValidation.h"

@implementation NSString (NSString_NSStringValidation)


+(BOOL)isEmpty:(NSString *)input{
    
    NSString *trimmedString = [input stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    
    if([trimmedString length] ==0){
        return true;
    }else{
        return false;
    }
}

+(NSString *)isValidPassword:(NSString *)password{
    
    NSCharacterSet* onlyNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    //Create character set
    NSCharacterSet *onlyChars = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"]invertedSet];
    
    if(password.length<6){
        return @"Password length should be atleast siz characters";
    }else if([password rangeOfCharacterFromSet:onlyNumbers].location == NSNotFound){
        NSLog(@"Passowrd contains only numbers");
        return @"Password should contain atleast one letter and one alphabet";
    }else if([password rangeOfCharacterFromSet:onlyChars].location==NSNotFound){
        return @"Password should contain atleast one letter and one alphabet";
    }
    
    return @"valid";
    
}

+(BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


@end
