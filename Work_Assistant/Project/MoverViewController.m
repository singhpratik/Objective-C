//
//  MoverViewController.m
//  Project
//
//  Created by Pratik Singh on 4/14/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "MoverViewController.h"
@import Firebase;
#import "DatePickerViewController.h"
#import "TableData.h"
#import "VehicleViewController.h"
#import "TaskDetailsViewController.h"
#import "Task.h"
#import <EventKit/EventKit.h>
#import "LoginViewController.h"
#import "MapViewController.h"
#import "SignedInViewController.h"

@interface MoverViewController ()

@end

int addEventGranted;
@implementation MoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"logout3"] style:UIBarButtonItemStylePlain target:self action:@selector(logout)];
    addButton.tintColor = [UIColor colorWithDisplayP3Red:121/255.0 green:182/255.0 blue:50/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    
    if(![self.taskObject.taskId isEqualToString:@"null"]){
        NSLog(@"Hello world");
        [self.addTaskButton setTitle:@"Update" forState:UIControlStateNormal];
    }
    
    self.flag = 0;
    
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
 
    [self.tableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // [START auth_listener]
    [[FIRAuth auth]
     addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
        // NSLog(@"Cuurent page is Movers Page %@",user.uid,user.email);
        // self.currentUser = [[User alloc]init];
         self.taskObject.taskUser = user.uid;
     }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.taskDetailsArray count];
}

-(UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *simpleIdentifier = @"SI";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:simpleIdentifier];

    if(cell==nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
 reuseIdentifier:simpleIdentifier];
    }
    
     TableData *cellLabel = [self.taskDetailsArray objectAtIndex:indexPath.row];
    
    cell.textLabel.textColor = [UIColor colorWithDisplayP3Red:121/255.0 green:182/255.0 blue:50/255.0 alpha:1.0];
    
    cell.detailTextLabel.textColor =[UIColor colorWithDisplayP3Red:139/255.0 green:139/255.0 blue:139/255.0 alpha:1.0];
    
     cell.textLabel.text = cellLabel.key;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:cellLabel.imageName]];
    
     cell.accessoryView = imageView;
     cell.detailTextLabel.text = cellLabel.value;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TableData *currentData = [self.taskDetailsArray objectAtIndex:indexPath.row];
    if([currentData.key isEqualToString:@"When"]){
        
        [self performSegueWithIdentifier:@"datePickerIdentifier" sender:self];
    }else if([currentData.key isEqualToString:@"Vehicle required"]){
        
        [self performSegueWithIdentifier:@"vehicleRequiredIdentifier" sender:self];
    }else if([currentData.key isEqualToString:@"Task Details"]){
        [self performSegueWithIdentifier:@"taskDetails" sender:self];
    }else if([currentData.key isEqualToString:@"Start Address"]){
        self.flag = 1;
        GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
        acController.delegate = self;
        [self presentViewController:acController animated:YES completion:nil];
    }else if([currentData.key isEqualToString:@"Destination Address"]){
    
        self.flag = 0;
        GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
        [acController.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"houseImage3"]]];
        acController.delegate = self;
        [self presentViewController:acController animated:YES completion:nil];
        
    }else if([currentData.key isEqualToString:@"Service"]){
        
        [self performSegueWithIdentifier:@"service" sender:self];
    }
}




// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.destinationViewController isKindOfClass:[VehicleViewController class]]){
        VehicleViewController *myController = segue.destinationViewController;
         myController.taskDetailsArray = self.taskDetailsArray;
        myController.hidesBottomBarWhenPushed = YES;
        myController.taskObject = self.taskObject;//passing the reference of task object
        
    }else if([segue.destinationViewController isKindOfClass:[DatePickerViewController class]]){
        DatePickerViewController *myController = segue.destinationViewController;
        myController.taskDetailsArray = self.taskDetailsArray;
        myController.hidesBottomBarWhenPushed = YES;//
        myController.taskObject = self.taskObject;//passing the reference of task object
        
    }else if([segue.destinationViewController isKindOfClass:[TaskDetailsViewController class]]){
        TaskDetailsViewController *myController = segue.destinationViewController;
        myController.taskDetailsArray = self.taskDetailsArray;
        myController.hidesBottomBarWhenPushed = YES;
        myController.taskObject = self.taskObject;//passing the reference of task object
    }else if([segue.destinationViewController isKindOfClass:[MapViewController class]]){
    
        MapViewController *myController = segue.destinationViewController;
        myController.taskDetailsArray = self.taskDetailsArray;
        myController.taskObject = self.taskObject;//passing the reference of task object
        
    }
    
    
}


- (IBAction)addTaskFunction:(id)sender {
    if([self.taskObject.taskType isEqualToString:@"null"]||[self.taskObject.taskAddress isEqualToString:@"null"]||[self.taskObject.taskType isEqualToString:@"null"]||[self.taskObject.description isEqualToString:@"null"]||[self.taskObject.taskVehicleReq isEqualToString:@"null"]||[self.taskObject.taskEndAddress isEqualToString:@"null"]){
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"All fields are mandatory"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    
    [self addEvent:self.taskObject.taskType  location:self.taskObject.taskAddress startDate:self.taskObject.taskDate];
    
    FIRDatabaseReference *dbRef;
    dbRef = [[FIRDatabase database]reference];

    
    if(![self.taskObject.taskId isEqualToString:@"null"]){
        NSLog(@"The key is %@",self.taskObject.taskId);
        NSDictionary *post = @{@"taskType":self.taskObject.taskType,
                               @"taskUser":self.taskObject.taskUser,
                               @"taskDate":self.taskObject.taskDate,
                               @"taskDescription":self.taskObject.taskdescription,
                               @"taskVehicleReq":self.taskObject.taskVehicleReq,
                               @"taskId":self.taskObject.taskId,
                               @"taskAddress":self.taskObject.taskAddress,
                               @"taskEndAddress":self.taskObject.taskEndAddress,
                               @"taskVendor":self.taskObject.taskVendor,
                                @"taskStatus":self.taskObject.taskStatus,
                               };
        
        NSString *x = [@"/tasks/" stringByAppendingString:self.taskObject.taskId];
        NSString *y =[x stringByReplacingOccurrencesOfString: @"\"" withString: @""];
        NSDictionary *childUpdates = @{x:post};
        [dbRef updateChildValues:childUpdates];
    }else{
    NSLog(@"The class is %@",NSStringFromClass([[[dbRef child:@"tasks"] childByAutoId] class]));
    NSString *key = [[dbRef child:@"tasks"] childByAutoId].key;
    
    [[[dbRef child:@"tasks"] child:key]
     setValue:@{@"taskType":self.taskObject.taskType,
                @"taskUser":self.taskObject.taskUser,
                @"taskDate":self.taskObject.taskDate,
                @"taskDescription":self.taskObject.taskdescription,
                @"taskVehicleReq":self.taskObject.taskVehicleReq,
                @"taskId":key,
                @"taskAddress":self.taskObject.taskAddress,
                @"taskEndAddress":self.taskObject.taskEndAddress,
                @"taskVendor":self.taskObject.taskVendor,
                @"taskStatus":self.taskObject.taskStatus,
                }];
    }
    
    [self.navigationController popViewControllerAnimated:self];
}


//event code
-(void)addEvent: (NSString *)taskName location:(NSString *)startLocation startDate:(NSString *)startDate{
  
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
    NSDate *dateObj = [dateFormat dateFromString:startDate];

   

    EKEventStore *eventStore = [[EKEventStore alloc]init];
    
    if([eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)]){
        [ eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            if(granted){
            
                addEventGranted =1;
                EKEvent *event = [EKEvent eventWithEventStore:eventStore];
                
                [event setTitle:taskName];
                [event setStartDate:dateObj];
                [event setEndDate:[[NSDate alloc]initWithTimeInterval:1200 sinceDate:event.startDate]];
                [event setLocation:startLocation];
                
                NSTimeInterval alarmOffset = -1*1440*60;
                EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:alarmOffset];
                [event addAlarm:alarm];
                
                [event setCalendar:[eventStore defaultCalendarForNewEvents]];
                NSError *err;
                [eventStore saveEvent:event span:EKSpanThisEvent error:&err];
                
            }
        }];
    }

}



//####################################following code is used for google autocomplete

// Handle the user's selection.

- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    
  
    
    
    if(self.flag==1){
          self.taskObject.taskAddress = place.formattedAddress;
    for(TableData *tabData in self.taskDetailsArray){
        if([tabData.key isEqualToString:@"Start Address"]){
            tabData.value = place.formattedAddress;
            break;
        }
    }
    }else {
          self.taskObject.taskEndAddress = place.formattedAddress;
        for(TableData *tabData in self.taskDetailsArray){
            if([tabData.key isEqualToString:@"Destination Address"]){
                tabData.value = place.formattedAddress;
                break;
            }
        }
    }
    
    NSLog(@"Place attributions %@", place.attributions.string);
}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}



@end
