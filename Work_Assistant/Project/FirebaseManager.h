//
//  FirebaseManager.h
//  Project
//
//  Created by Pratik Singh on 4/7/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

@import FirebaseDatabase;

@interface FirebaseManager : NSObject

@property (strong, nonatomic) FIRDatabaseReference *ref;

-(FIRDatabaseReference *)getDatabaseReference;

@end
