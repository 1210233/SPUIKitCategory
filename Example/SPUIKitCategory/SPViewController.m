//
//  SPViewController.m
//  SPUIKitCategory
//
//  Created by 1210233 on 03/07/2020.
//  Copyright (c) 2020 1210233. All rights reserved.
//

#import "SPViewController.h"
#import "ViewController.h"
#import "UIViewController+XIBCreation.h"
#import "SPView.h"
#import "UIView+XIBCreation.h"

@interface SPViewController ()

@end

@implementation SPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)click {
//    ViewController *vc = [ViewController loadFromNib];
    
//    [self presentViewController:vc animated:YES completion:nil];
    
    SPView *v = [SPView loadFromNib];
    
    [self.view addSubview:v];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
