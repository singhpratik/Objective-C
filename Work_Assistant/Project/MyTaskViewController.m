//
//  MyTaskViewController.m
//  Project
//
//  Created by Pratik Singh on 4/25/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "MyTaskViewController.h"
@import Firebase;
#import "Task.h"
#import "TableData.h"
#import "MoverViewController.h"
#import "LoginViewController.h"


@interface MyTaskViewController ()

@end

@implementation MyTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout3"] style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    addButton.tintColor = [UIColor colorWithDisplayP3Red:121/255.0 green:182/255.0 blue:50/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = addButton;
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
   // [self getTaskDetails];
    // Do any additional setup after loading the view.
}


-(void)logout{
    
    NSError *signOutError;
    BOOL status = [[FIRAuth auth] signOut:&signOutError];
    if (!status) {
        NSLog(@"Error signing out: %@", signOutError);
    }else{
        
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        LoginViewController *vc = [sb instantiateViewControllerWithIdentifier:@"loginNavigationController"];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [self presentViewController:vc animated:YES completion:NULL];
    }
    
    
}




-(void)getTaskDetails:(NSString *)userId{

     FIRDatabaseReference *ref;
    ref = [[FIRDatabase database] reference];
    
    [[[[ref child:@"tasks"] queryOrderedByChild:@"taskUser"]
      queryEqualToValue:userId]
     observeEventType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
         
         self.taskArray = [[NSMutableArray alloc]init];
         self.completedTask = [[NSMutableArray alloc]init];
         self.pendingTask =[[NSMutableArray alloc]init];
         
         
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
                 
                 
                 if([taskObj.taskStatus isEqualToString:@"incomplete"]){
                 
                      [self.pendingTask addObject:taskObj];
                 }else{
                     [self.completedTask addObject:taskObj];
                 }
                 
                 //dateCheck
//                 NSDate *currentDate = [[NSDate date]init];
//                 NSString *currentDateString = [[NSString alloc]initWithFormat:@"%@", currentDate];
//                
//                 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                 formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss Z";
//                 currentDateString = [formatter stringFromDate:(currentDate)];
//                 
//                 NSDate *currentDate1 = [formatter dateFromString:currentDateString];
//                 NSLog(@"the Cureent date  is %@",currentDate1);
//                 NSDate *taskDate1 = [formatter dateFromString:taskObj.taskDate];
//                 
//                 
//                 
//                 if([currentDate1 compare:taskDate1]==NSOrderedDescending){
//                     [self.completedTask addObject:taskObj];
//                     
//                     NSLog(@"Completed task");
//                 }else{
//                       [self.pendingTask addObject:taskObj];
//                     NSLog(@"pending task");
//                 }
                 
                self.taskArray = self.pendingTask;

             }
         }
         
         self.searchItems = [[NSMutableArray alloc]initWithArray:self.taskArray];
         [self.tableView reloadData];
     }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // [START auth_listener]
    [[FIRAuth auth]
     addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
        [self getTaskDetails:user.uid];
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [self performSegueWithIdentifier:@"updateDetails" sender:self];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   
    NSMutableArray *tableArray = [[NSMutableArray alloc]init];
    TableData *tableDataTaskAdd = [[TableData alloc]init];
    tableDataTaskAdd.key = @"Start Address";
    tableDataTaskAdd.value = self.taskObj.taskAddress;
    tableDataTaskAdd.imageName = @"editoption";
    [tableArray addObject:tableDataTaskAdd];
    
    TableData *tableDataTaskEnd= [[TableData alloc]init];
    tableDataTaskEnd.key = @"Destination Address";
    tableDataTaskEnd.value = self.taskObj.taskEndAddress;
    tableDataTaskEnd.imageName = @"editoption";
    [tableArray addObject:tableDataTaskEnd];
    
    TableData *tableDataTime= [[TableData alloc]init];
    tableDataTime.key = @"When";
    tableDataTime.value = self.taskObj.taskDate;
    tableDataTime.imageName = @"editoption";
    [tableArray addObject:tableDataTime];
    
    TableData *tableDataVehicle= [[TableData alloc]init];
    tableDataVehicle.key = @"Vehicle required";
    tableDataVehicle.value = self.taskObj.taskVehicleReq;
    tableDataVehicle.imageName = @"editoption";
    [tableArray addObject:tableDataVehicle];
    
    TableData *taskDataDetail= [[TableData alloc]init];
    taskDataDetail.key = @"Task Details";
    taskDataDetail.value = self.taskObj.taskdescription;
    taskDataDetail.imageName = @"editoption";
    [tableArray addObject:taskDataDetail];
    
    MoverViewController *viewController  = segue.destinationViewController;
    viewController.taskDetailsArray = tableArray;
    viewController.taskObject = self.taskObj;
}


//following section is for the delete operation



// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    FIRDatabaseReference *dbRef;
    dbRef = [[FIRDatabase database]reference];

    Task *deleteTaskObj = [self.taskArray objectAtIndex:indexPath.row];
    NSString *x = [deleteTaskObj.taskId stringByReplacingOccurrencesOfString: @"\"" withString: @""];
    [[[dbRef child:@"tasks"] child:x] removeValueWithCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
        if(!error){
            [self.tableView reloadData];
        }
    }];
}


- (IBAction)segmentTaskAction:(id)sender {
    
    NSString *title = [self.segementTask titleForSegmentAtIndex:[self.segementTask selectedSegmentIndex]];
    if([title isEqualToString:@"Pending"]){
        self.taskArray = self.pendingTask;
        NSLog(@"the tasks are inside pending task");
    }else if([title isEqualToString:@"Completed"]){
        self.taskArray = self.completedTask;
        NSLog(@"the tasks are completed task");
    }
    self.searchItems = [[NSMutableArray alloc]initWithArray:self.taskArray];
    [self.tableView reloadData];
    
}
@end
