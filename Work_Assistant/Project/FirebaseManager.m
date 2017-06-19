//
//  FirebaseManager.m
//  Project
//
//  Created by Pratik Singh on 4/7/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FirebaseManager.h"
@import Firebase;
@import FirebaseDatabase;

@implementation FirebaseManager

- (id)init{
    self = [super init];
    if (self) {
        _ref = [[FIRDatabase database]reference];
    }
    return self;
}

-(FIRDatabaseReference *)getDatabaseReference{
    //self.ref = [[FIRDatabase database]reference];
    return self.ref;
}

@end


