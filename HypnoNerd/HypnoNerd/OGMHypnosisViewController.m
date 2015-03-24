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
@end

@implementation OGMHypnosisViewController

// overriding/creating a view controllers view programmatically
- (void) loadView
{
    CGRect frame =  [UIScreen mainScreen].bounds;
    
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
        
        // Set the label's initial alpha
        messageLabel.alpha = 0.0;
        
        // Animate the alpha to 1.0
        [UIView animateWithDuration:0.5
                              delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             messageLabel.alpha = 1.0;
                         }
                         completion:NULL];
        
        [UIView animateKeyframesWithDuration:1.0
                                       delay:0.0
                                     options:0
                                  animations:^{
                                      [UIView addKeyframeWithRelativeStartTime:0
                                                              relativeDuration:0.8
                                                                    animations:^{
                                                                        messageLabel.center = self.view.center;
                                                                    }];
                                      [UIView addKeyframeWithRelativeStartTime:0.8
                                                              relativeDuration:0.2
                                                                    animations:^{
                                                                        int x = arc4random() % width;
                                                                        int y = arc4random() % height;
                                                                        messageLabel.center = CGPointMake(x, y);
                                                                    }];
                                  }completion:NULL];
        
        
        
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

@end
