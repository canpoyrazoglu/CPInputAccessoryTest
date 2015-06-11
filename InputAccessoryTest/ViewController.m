//
//  ViewController.m
//  InputAccessoryTest
//
//  Created by Can Poyrazoğlu on 11.06.15.
//  Copyright (c) 2015 Can Poyrazoğlu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    NSArray *constraintsOfTextInputView;
    UITextView *editingTextView;
}

- (IBAction)dismissTapped:(id)sender {
    [editingTextView resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
}

-(NSArray*)constraintsRelatedToView:(UIView*)view{
    NSMutableArray *array = [NSMutableArray array];
    for (NSLayoutConstraint *constraint in self.view.constraints) {
        if(constraint.firstItem == view || constraint.secondItem == view){
            [array addObject:constraint];
        }
    }
    return array;
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    UIView *inputView = self.textInputView; //this is the main view that we are adding to top of keyboard.
    constraintsOfTextInputView = [self constraintsRelatedToView:inputView]; //get all constraints of that view and store.
    [inputView removeFromSuperview]; //not really needed, just convenience for running when next line is commented out
    [[UIApplication sharedApplication].keyWindow addSubview:self.textInputView]; //adds that view to window (if I don't call it it doesn't get added)
    textView.inputAccessoryView = inputView; //set it as the input accessory view for the active text view
    editingTextView = textView; //store a ref to editing text view
    return YES;
}

-(void)keyboardWillHide{
    if(editingTextView && constraintsOfTextInputView){ //if we are editing
        editingTextView.inputAccessoryView = nil; //set input accessory view to nil
        [self.textInputView removeFromSuperview]; //remove our accessory view from whatever container it was in (I confirm it gets nil here)
        
        // THE NEXT LINE THROWS EXCEPTION !!!
        
        [self.view addSubview:self.textInputView]; //add our view back to view controller's hiearchy, effectively undo-ing what we've done initially.
        [self.view addConstraints:constraintsOfTextInputView]; //add the constraints again
        [self.view layoutIfNeeded];
        
        editingTextView = nil;
        constraintsOfTextInputView = nil;
    }
}

@end
