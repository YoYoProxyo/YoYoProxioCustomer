//
//  DetailController.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "DetailController.h"
#import "SignInController.h"
#import "PayController.h"

@interface DetailController ()
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *size;
@property (weak, nonatomic) IBOutlet UIView *userOffers;
@property (weak, nonatomic) IBOutlet UIView *userPay;

@end

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.itemTitle setText:[NSString stringWithFormat:@"%@ %@", self.item.manufacturer, self.item.itemType]];
    [self.image setImage:self.item.image];
    [self.price setText:[NSString stringWithFormat:@"£%@", self.item.price]];
    [self.size setText:[NSString stringWithFormat:@"Size %@", self.item.size]];
    
    [self.manager.pusher sendMessage:[StatusMessage action:@"viewed" withUser:self.manager.user andObject:self.item]];
}
-(void) viewDidAppear:(BOOL)animated {
    
    
    [super viewDidAppear:animated];
    
    if (self.manager.user.loggedIn) {
        [self.userPay setHidden:YES];
        [self.userOffers setHidden:NO];
    } else {
        [self.userPay setHidden:NO];
        [self.userOffers setHidden:YES];
    }
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender    {
    
    if ([segue.destinationViewController isKindOfClass:[SignInController class]]) {
        SignInController* controller = segue.destinationViewController;
        controller.manager = self.manager;
    } else if ([segue.destinationViewController isKindOfClass:[PayController class]]) {
        PayController* controller = (PayController*) segue.destinationViewController;
        controller.manager = self.manager;
        controller.item = self.item;
    }
}

@end
