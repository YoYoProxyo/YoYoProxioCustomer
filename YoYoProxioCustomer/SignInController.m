
//
//  SignInController.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 08/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "SignInController.h"

@interface SignInController ()

@end

@implementation SignInController
@synthesize manager = _manager;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)signInButton:(id)sender {
    StatusMessage* message = [StatusMessage action:@"signin" withUser:self.manager.user andObject:[YYPItem nilItem]];
    
    self.manager.user.loggedIn = YES;
    self.manager.user.username = @"Lyndsay Thackrah";
    
    message.arg1 = self.manager.user.username;
    [self.manager.pusher sendMessage:message];
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end
