//
//  QuizViewController.m
//  Quiz
//
//  Created by Omri Meshulam on 2/14/15.
//  Copyright (c) 2015 OmriMeshulam. All rights reserved.
//

#import "OGMQuizViewController.h"

@interface OGMQuizViewController ()

@property (nonatomic) int currentQuestionIndex;
@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, copy) NSArray *answers;


@property (nonatomic, weak) IBOutlet UILabel *questionLabel;
@property (nonatomic, weak) IBOutlet UILabel *answerLabel;

@end

@implementation OGMQuizViewController

// designated initializer for UIViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
{
    // Call the init method implemented by superclass
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // create 2 arrays filled with questions and answers.
        // and make pointers to them
        
        self.questions = @[@"From what is cognac made?",
                           @"What is 7 + 7",
                           @"What is the capital of Vermont?"];
        self.answers = @[@"Grapes",
                         @"14",
                         @"Montpelier"];
        
        self.restorationIdentifier = NSStringFromClass([self class]);
        self.restorationClass = [self class];
        
        // Getting the tab bar item
        UITabBarItem *tbi = self.tabBarItem;
        
        // Giving it a lable
        tbi.title = @"Quiz";
        
        // Giving it an image
        // current png not working
        UIImage *i = [UIImage imageNamed:@"Quiz.png"];
        tbi.image = i;
        
        // Setting restoration identifier
        self.restorationIdentifier = NSStringFromClass([self class]);
    }
    //return the address of the new object
    return self;
    
}

- (IBAction)showQuestion:(id)sender
{
    // Step to the next question
    self.currentQuestionIndex++;
    
    // If past the last question
    if (self.currentQuestionIndex == [self.questions count]){
        //go back to first question
        self.currentQuestionIndex = 0;
    }
    
    //get the string at the index in the question array
    NSString *question = self.questions[self.currentQuestionIndex];
    
    //display the string in the question label
    self.questionLabel.text = question;
    
    //reset the answer label
    self.answerLabel.text = @"???";
    
    
}
- (IBAction)showAnswer:(id)sender
{
    //string answer to current question
    NSString *answer = self.answers[self.currentQuestionIndex];
    
    //displaying in the answer label
    self.answerLabel.text = answer;
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [coder encodeInt:self.currentQuestionIndex forKey:@"currentQuestionIndex"];
    [coder encodeObject:self.answerLabel.text forKey:@"answerLabel.text"];
    [coder encodeObject:self.questionLabel.text forKey:@"questionLabel.text"];
    
    // call the super class
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.currentQuestionIndex = [coder decodeIntForKey:@"currentQuestionIndex"];
    self.answerLabel.text = [coder decodeObjectForKey:@"answerLabel.text"];
    self.questionLabel.text = [coder decodeObjectForKey:@"questionLabel.text"];
    
    [super decodeRestorableStateWithCoder:coder];
}


@end


