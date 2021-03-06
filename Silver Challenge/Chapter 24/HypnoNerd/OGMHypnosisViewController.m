//
//  OGMHypnosisViewController.m
//  HypnoNerd
//
//  Created by Omri Meshulam on 2/26/15.
//  Copyright (c) 2015 Omri Meshulam. All rights reserved.
//

#import "OGMHypnosisViewController.h"
#import "OGMHypnosisView.h"

@interface OGMHypnosisViewController() <UITextFieldDelegate> // Conforming to UITextFieldDelegate protocol

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *messages;

@end

@implementation OGMHypnosisViewController

// overriding/creating a view controllers view programmatically
- (void) loadView
{    
    // Creating a view
    OGMHypnosisView *backgroundView = [[OGMHypnosisView alloc] init];
    
    CGRect textFieldRect = CGRectMake(65, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame:textFieldRect];
    
    // Setting the border style on the text field will allow us to see it more easily
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    
    // updating loadView to set the delegate property of the UITextField to point at HypnosisViewController
    textField.delegate = self;
    
    [backgroundView addSubview:textField];
    
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
        
        // Setting the restoration identifier
        self.restorationIdentifier = NSStringFromClass([self class]);
        //restoration class not required
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];
    
    [self.messages addObject:textField.text];
    
    textField.text = @"";
    [textField resignFirstResponder];
    
    return YES;
}

- (void)drawHypnoticMessage:(NSString *) message
{
    for (int i = 0; i < 20; i++)
    {
        UILabel *messageLabel = [[UILabel alloc] init];
        
        // Configure the label's color and text
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        
        // This method resizes the label which will be relative to the text it is displaying
        [messageLabel sizeToFit];
        
        // Getting a random x value that fits within the hypnosis view's width
        int width = (int)((self.view.bounds.size.width) - (messageLabel.bounds.size.width));
        int x = arc4random() % width;
        
        // Getting a random y value that fits within the hypnosis view's height
        int height = (int)((self.view.bounds.size.height) - (messageLabel.bounds.size.height));
        int y = arc4random() % height;
        
        // Updating the label's frame
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        // adding the label to the hierarchy
        [self.view addSubview:messageLabel];
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x" type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y" type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    }
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    [coder encodeObject:self.textField.text forKey:@"textField.text"];
    [coder encodeObject:self.messages forKey:@"array.messages"];
    
    // call the super class
    [super encodeRestorableStateWithCoder:coder];
}

- (void) decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.textField.text = [coder decodeObjectForKey:@"textField.text"];
    self.messages = [[NSMutableArray alloc] initWithArray:[coder decodeObjectForKey:@"array.messages"]];
    
    for(NSString *msg in self.messages ) {
        [self drawHypnoticMessage:msg];
    }
    
    if(self.textField.text) {
        [self.textField becomeFirstResponder];
    } else {
        [self.textField resignFirstResponder];
    }
    
    
    [super decodeRestorableStateWithCoder:coder];
}

@end
