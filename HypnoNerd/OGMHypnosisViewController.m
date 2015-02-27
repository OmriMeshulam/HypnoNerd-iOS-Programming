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

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        // Setting the tab bar items title
        self.tabBarItem.title = @"Hypnotize";
        
        // Creating a UIImage from a file
        // This will use Hypno@2x.png on retina display devices
        UIImage *i = [UIImage imageNamed:@"Hypno.png"];
        
        // Putting the image on the tab bar item
        self.tabBarItem.image = i;
    }
    
    return self;
}

// Overriding to show a message
- (void) viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"OGMHypnosisViewController loaded its view.");
}

@end
