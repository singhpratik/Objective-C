//
//  Task.h
//  Project
//
//  Created by Pratik Singh on 4/14/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Task : NSObject

@property (strong,nonatomic) NSString*taskId;
@property (strong,nonatomic) NSString *taskType;
@property (strong,nonatomic) NSString *taskUser;
@property (strong,nonatomic) NSString *taskDate;
@property (strong,nonatomic) NSString *taskVehicleType;
@property (strong,nonatomic) NSString *taskAddress;
@property (strong,nonatomic) NSString *taskEndAddress;
@property (strong,nonatomic) NSString *taskImage;
@property (strong,nonatomic) NSString *taskVehicleReq;
@property (strong,nonatomic) NSString *taskdescription;
@property (strong,nonatomic) NSString *taskVendor;
@property (strong,nonatomic) NSString *taskStatus;



+(void)initialiseAll:(Task *)taskObject;

@end
