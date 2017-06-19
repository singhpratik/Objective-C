//
//  CALayer+CALayer_XibConfiguration_h.m
//  Project
//
//  Created by Pratik Singh on 4/4/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import "CALayer+CALayer_XibConfiguration_h.h"

@implementation CALayer (CALayer_XibConfiguration_h)

// This assigns a CGColor to borderColor.
-(void)setBorderUIColor:(UIColor*)color
{
    self.borderColor = color.CGColor;
}

-(UIColor*)borderUIColor
{
    return [UIColor colorWithCGColor:self.borderColor];
}

@end
