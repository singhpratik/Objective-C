//
//  Vendors.m
//  Project
//
//  Created by Pratik Singh on 4/29/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Vendors.h"

@implementation Vendors

-(NSMutableArray *)getVendorList{
    NSMutableArray *vendorList = [[NSMutableArray alloc]init];
    Vendors *vendor1 = [[Vendors alloc]init];
    vendor1.vendorName = @"Fast Track Service";
    vendor1.VendorCost = @"270.6$";
    vendor1.latitude = 42.335443;
    vendor1.longitude = -71.09951;
    [vendorList addObject:vendor1];
    
    Vendors *vendor2 = [[Vendors alloc]init];
    vendor2.vendorName = @"Easy Move";
    vendor2.VendorCost = @"293.9$";
    vendor2.latitude = 42.334311;
    vendor2.longitude = -71.100762;
    [vendorList addObject:vendor2];
    
    Vendors *vendor3 = [[Vendors alloc]init];
    vendor3.vendorName = @"Pack & Go";
    vendor3.VendorCost = @"266.3$";
    vendor3.latitude = 42.333052;
    vendor3.longitude = -71.099360;
    [vendorList addObject:vendor3];
    
    Vendors *vendor4 = [[Vendors alloc]init];
    vendor4.vendorName = @"Pack & Go";
    vendor4.VendorCost = @"272.3$";
    vendor4.latitude = 42.338285;
    vendor4.longitude = -71.088861;
    [vendorList addObject:vendor4];
    
    Vendors *vendor5= [[Vendors alloc]init];
    vendor5.vendorName = @"Moving Easy";
    vendor5.VendorCost = @"272.3$";
    vendor5.latitude = 42.338773;
    vendor5.longitude = -71.088923;
    [vendorList addObject:vendor5];
    
    Vendors *vendor6= [[Vendors alloc]init];
    vendor6.vendorName = @"Ruggles Moving";
    vendor6.VendorCost = @"272.3$";
    vendor6.latitude = 42.336647;
    vendor6.longitude = -71.089407;
    [vendorList addObject:vendor6];
    
    return vendorList;
}

@end
