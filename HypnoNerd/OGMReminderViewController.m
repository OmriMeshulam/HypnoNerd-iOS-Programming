//
//  OGMReminderViewController.m
//  HypnoNerd
//
//  Created by Omri Meshulam on 2/26/15.
//  Copyright (c) 2015 Omri Meshulam. All rights reserved.
//

#import "OGMReminderViewController.h"

@interface OGMReminderViewController ()

@property (nonatomic, weak) IBOutlet UIDatePicker *datePicker;

@end

@implementation OGMReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
}


@end
