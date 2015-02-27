//
//  OGMHypnosisViewController.m
//  HypnoNerd
//
//  Created by Omri Meshulam on 2/26/15.
//  Copyright (c) 2015 Omri Meshulam. All rights reserved.
//

#import "OGMHypnosisViewController.h"
#import "OGMHypnosisView.h"

@implementation OGMHypnosisViewController

- (void) loadView
{
    // Creating a view
    OGMHypnosisView *backgroundView = [[OGMHypnosisView alloc] init];
    
    // Setting it as *the* view of the view controller
    self.view = backgroundView;
}

@end
