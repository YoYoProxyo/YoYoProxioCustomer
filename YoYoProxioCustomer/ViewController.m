//
//  ViewController.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "ViewController.h"
#import "UserManager.h" 

#import "SignInController.h"
#import "BrowseController.h"

@interface ViewController ()
@property (strong, nonatomic) UserManager* manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.manager = [UserManager newManager];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[SignInController class]]) {
        SignInController* controller = (SignInController*) segue.destinationViewController;
        controller.manager = self.manager;
    } else if ([segue.destinationViewController isKindOfClass:[BrowseController class]]) {
        BrowseController* controller = (BrowseController*) segue.destinationViewController;
        controller.manager = self.manager;
    }
}

-(void) viewDidAppear:(BOOL)animated
{
    if (self.manager.user.loggedIn) {
        [self performSegueWithIdentifier:@"showBrowse" sender:self];
    }
    [super viewDidAppear:animated];
}
@end
