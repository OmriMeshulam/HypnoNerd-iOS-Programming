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

// Overriding to show a message
- (void) viewDidLoad
{
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"OGMReminderViewController loaded its view.");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}

- (IBAction)addReminder:(id)sender
{
    NSDate *date = self.datePicker.date;
    NSLog(@"Setting a reminder for %@", date);
    
    UILocalNotification *note = [[UILocalNotification alloc] init];
    note.alertBody = @"Hypnotize me!";
    note.fireDate = date;
    
    // asks if needed for user permission
    [[UIApplication sharedApplication] registerUserNotificationSettings:
     [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert)
                                       categories:nil]];
    
    [[UIApplication sharedApplication] scheduleLocalNotification:note];

}

// designated initializer for UIViewController
- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self){
        // Getting the tab bar item
        UITabBarItem *tbi = self.tabBarItem;
    
        // Giving it a lable
        tbi.title = @"Reminder";
        
        // Giving it an image
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        tbi.image = i;
        
        // Setting restoration identifier
        self.restorationIdentifier = NSStringFromClass([self class]);
    }
    
    return self;
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [coder encodeObject:self.datePicker.date forKey:@"reminder.date"];
    
    // call the super class
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.datePicker.date = [coder decodeObjectForKey:@"reminder.date"];
    
    [super decodeRestorableStateWithCoder:coder];
}


@end
