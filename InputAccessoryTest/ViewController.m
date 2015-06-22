//
//  ViewController.m
//  InputAccessoryTest
//
//  Created by Can Poyrazoğlu on 11.06.15.
//  Copyright (c) 2015 Can Poyrazoğlu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate>

@property (nonatomic, strong) UIView *inputAccessoryView;
@end

@implementation ViewController

- (void)loadView
{
    UIScrollView *const scrollView = [[UIScrollView alloc] initWithFrame:UIScreen.mainScreen.applicationFrame];
    scrollView.alwaysBounceVertical = YES;
    scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
    scrollView.backgroundColor = UIColor.whiteColor;

    self.view = scrollView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [UIView performWithoutAnimation:^{
        [self becomeFirstResponder];
    }];
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (UIView *)inputAccessoryView
{
    if (_inputAccessoryView == nil) {
        _inputAccessoryView = ({
            UITextView *const textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
            textView.backgroundColor = UIColor.redColor;
            textView;
        });
    }

    return _inputAccessoryView;
}

@end
