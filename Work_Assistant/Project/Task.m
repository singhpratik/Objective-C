//
//  Task.m
//  Project
//
//  Created by Pratik Singh on 4/14/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "Task.h"

@implementation Task

+(void)initialiseAll:(Task *)taskObject{
    
    taskObject.taskUser=@"null";
    taskObject.taskVehicleReq=@"null";
    taskObject.taskdescription=@"null";
    taskObject.taskDate=@"null";
    taskObject.taskAddress=@"null";
    taskObject.taskEndAddress=@"null";
    taskObject.taskImage=@"null";
    taskObject.taskType=@"null";
    taskObject.taskId=@"null";
    taskObject.taskVendor=@"null";
    taskObject.taskStatus =@"incomplete";
}

+(NSMutableArray *)getAllTask:(NSString *)userId{
    NSMutableArray *taskArray = [[NSMutableArray alloc]init];
    
    return taskArray;
}

@end
