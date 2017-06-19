//
//  SignedInViewController.h
//  Project
//
//  Created by Pratik Singh on 4/7/17.
//  Copyright © 2017 Pratik Singh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignedInViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *moverView;

@property (weak, nonatomic) IBOutlet UIView *cleaningView;
@property (weak, nonatomic) IBOutlet UIView *handmanView;
@property (weak, nonatomic) IBOutlet UIView *generalHelp;

@property (weak, nonatomic) IBOutlet UIImageView *handyManImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cleaningImageView;
@property (weak, nonatomic) IBOutlet UIImageView *generalHelpImageView;
@property (weak, nonatomic) IBOutlet UIImageView *moverImageView;
@property (weak,nonatomic) NSString *taskName;


//functions for UIVIew


@end
