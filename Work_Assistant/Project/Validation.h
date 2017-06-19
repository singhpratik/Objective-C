//
//  Validation.h
//  Project
//
//  Created by Pratik Singh on 4/7/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validation : NSObject



//is Empty
+(BOOL)isEmpty:(NSString *)input;

//password validation
+(NSString *)isValidPassword:(NSString *)password;

//email validation
-(BOOL) NSStringIsValidEmail:(NSString *)checkString;

@end
