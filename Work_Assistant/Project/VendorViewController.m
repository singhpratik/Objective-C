//
//  VendorViewController.m
//  Project
//
//  Created by Pratik Singh on 4/29/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "VendorViewController.h"
#import "Task.h"
#import "LoginViewController.h"
@import Firebase;

@interface VendorViewController ()

@end

@implementation VendorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
//    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout3"] style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
//    addButton.tintColor = [UIColor colorWithDisplayP3Red:121/255.0 green:182/255.0 blue:50/255.0 alpha:1.0];
//    self.navigationItem.rightBarButtonItem = addButton;
    
    // Do any additional setup after loading the view.
    self.navigationItem.backBarButtonItem.title =@"Logout";
    [self getTaskDetails];
}



-(void)getTaskDetails{
    
    FIRDatabaseReference *ref;
    ref = [[FIRDatabase database] reference];
    
    [[ref child:@"tasks"]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
    
         self.taskArray = [[NSMutableArray alloc]init];
         self.completedTask = [[NSMutableArray alloc]init];
         self.pendingTask =[[NSMutableArray alloc]init];
         self.completeList =[[NSMutableArray alloc]init];
         
         
         if (snapshot.value != [NSNull null]){
             
             for (NSDictionary *snap in [snapshot.value allValues]) {
                 Task *taskObj = [[Task alloc]init];
                 taskObj.taskType = [snap objectForKey:@"taskType"];
                 taskObj.taskDate = [snap objectForKey:@"taskDate"];
                 taskObj.taskVehicleReq = [snap objectForKey:@"taskVehicleReq"];
                 taskObj.taskUser = [snap objectForKey:@"taskUser"];
                 taskObj.taskdescription = [snap objectForKey:@"taskDescription"];
                 taskObj.taskId = [snap objectForKey:@"taskId"];
                 taskObj.taskAddress = [snap objectForKey:@"taskAddress"];
                 taskObj.taskEndAddress = [snap objectForKey:@"taskEndAddress"];
                 taskObj.taskVendor = [snap objectForKey:@"taskVendor"];
                 taskObj.taskStatus = [snap objectForKey:@"taskStatus"];
                 taskObj.taskImage =@"null";
                 
                 [self.completeList addObject:taskObj];
                 
                 if([taskObj.taskStatus isEqualToString:@"incomplete"]){
                     [self.pendingTask addObject:taskObj];
                 }
                 //dateCheck
                 self.taskArray = self.pendingTask;
             }
         }
         self.searchItems = [[NSMutableArray alloc]initWithArray:self.taskArray];
         [self.tableView reloadData];
     }];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return [self.searchItems count];
}

-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *simpleIdentifier = @"SI";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleIdentifier];
    
    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleIdentifier];
    }
    
    Task *taskObj = self.searchItems[indexPath.row];
    
    cell.textLabel.textColor = [UIColor colorWithDisplayP3Red:121/255.0 green:182/255.0 blue:50/255.0 alpha:1.0];
    
    cell.detailTextLabel.textColor =[UIColor colorWithDisplayP3Red:139/255.0 green:139/255.0 blue:139/255.0 alpha:1.0];
    
    cell.textLabel.text = taskObj.taskType;
    cell.detailTextLabel.text = taskObj.taskDate;
    cell.backgroundColor = [UIColor colorWithRed:254 green:218 blue:182 alpha:0];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"correct"]];
    
    if([taskObj.taskImage isEqualToString:@"complete"]){
        NSLog(@"inside accessory view");
        cell.accessoryView = imageView;
    }else{
        cell.accessoryView = nil;
        
    }
    return cell;
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if([searchText length]==0){
        [self.searchItems removeAllObjects];
        [self.searchItems addObjectsFromArray:self.taskArray];
    }else{
        [self.searchItems removeAllObjects];
        for(Task * searchMenuitem in self.taskArray){
            NSRange r = [searchMenuitem.taskType rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(r.location!=NSNotFound){
                [self.searchItems addObject:searchMenuitem];
            }
        }
    }
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   self.taskObj = [self.taskArray objectAtIndex:indexPath.row];

    if([self.taskObj.taskImage isEqualToString:@"incomplete"]){
        NSLog(@"inside incomplete block");
        self.taskObj.taskStatus = @"complete";
        self.taskObj.taskImage = @"complete";
    }else{
        NSLog(@"inside complete block");
        self.taskObj.taskStatus = @"incomplete";
        self.taskObj.taskImage = @"incomplete";
    }
    
    [self.tableView reloadData];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)completeButtonFunction:(id)sender {
    FIRDatabaseReference *dbRef;
    dbRef = [[FIRDatabase database]reference];

    for(Task *taskObject in self.completeList){
        NSLog(@"task Name is %@",taskObject.taskType);
        NSLog(@"The key is %@",taskObject.taskId);
        NSDictionary *post = @{@"taskType":taskObject.taskType,
                               @"taskUser":taskObject.taskUser,
                               @"taskDate":taskObject.taskDate,
                               @"taskDescription":taskObject.taskdescription,
                               @"taskVehicleReq":taskObject.taskVehicleReq,
                               @"taskId":taskObject.taskId,
                               @"taskAddress":taskObject.taskAddress,
                               @"taskEndAddress":taskObject.taskEndAddress,
                               @"taskVendor":taskObject.taskVendor,
                               @"taskStatus":taskObject.taskStatus,
                               @"taskImage":@"null",
                               };
        NSLog(@"the task status is %@",taskObject.taskStatus);
        
        NSString *x = [@"/tasks/" stringByAppendingString:taskObject.taskId];
        NSString *y =[x stringByReplacingOccurrencesOfString: @"\"" withString: @""];
        NSDictionary *childUpdates = @{x:post};
            [dbRef updateChildValues:childUpdates];
    }
    [self getTaskDetails];
}

- (IBAction)segmentFunction:(id)sender {
    
    NSString *status = [self.segmentStatus titleForSegmentAtIndex:[self.segmentStatus selectedSegmentIndex]];
    if([status isEqualToString:@"Pending"]){
        self.taskArray = self.pendingTask;
    }else{
        NSLog(@"inside Completed task");
        self.taskArray = self.completedTask;
    }
    [self.tableView reloadData];
}
@end
