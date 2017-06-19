//
//  NSString+NSString_NSStringValidation.h
//  Project
//
//  Created by Pratik Singh on 4/8/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSString_NSStringValidation)



//is Empty
+(BOOL)isEmpty:(NSString *)input;

//password validation
+(NSString *)isValidPassword:(NSString *)password;

//email validation
+(BOOL) isValidEmail:(NSString *)checkString;

@end
