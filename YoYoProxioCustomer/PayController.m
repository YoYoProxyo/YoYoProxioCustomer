//
//  PayController.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "PayController.h"

@interface PayController ()
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UIImageView *qrCode;
@property (weak, nonatomic) IBOutlet UIImageView *purchased;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *size;

@end

@implementation PayController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.item) {
        self.item = [YYPItem dress];
    }
    // Do any additional setup after loading the view.
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    [self.qrCode addGestureRecognizer:singleTap];
    [self.qrCode setUserInteractionEnabled:YES];
    
    [self.image setImage:self.item.image];
    [self.itemTitle setText:[NSString stringWithFormat:@"%@ %@", self.item.manufacturer, self.item.itemType]];
    [self.image setImage:self.item.image];
    [self.price setText:[NSString stringWithFormat:@"£%@", self.item.price]];
    [self.size setText:[NSString stringWithFormat:@"Size %@", self.item.size]];
}

- (void)imageTapped:(UIGestureRecognizer *)gestureRecognizer {
    
    if (!self.item) {
        self.item = [YYPItem dress];
    }
    [self.manager.pusher sendMessage:[StatusMessage action:@"sale" withUser:self.manager.user andObject:self.item]];
    [self.manager.pusher sendSale:[StatusMessage action:@"sale" withUser:self.manager.user andObject:self.item]];
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Sale successful"
                                                                   message:@"Security tag is deactivated"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
    [self.purchased setHidden:NO];
}

@end
