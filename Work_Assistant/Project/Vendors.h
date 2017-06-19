//
//  Vendors.h
//  Project
//
//  Created by Pratik Singh on 4/29/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vendors : NSObject

@property (strong,nonatomic) NSString *vendorName;
@property (strong,nonatomic) NSString *VendorCost;
@property double latitude;
@property double longitude;

@property (strong,nonatomic) NSMutableArray *vendorList;

-(NSMutableArray *)getVendorList;

@end
