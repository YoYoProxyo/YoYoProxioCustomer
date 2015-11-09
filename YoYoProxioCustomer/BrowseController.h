//
//  BrowseController.h
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"

typedef enum : int
{
    ESTScanTypeBluetooth,
    ESTScanTypeBeacon
    
} ESTScanType;

@interface BrowseController : UIViewController
@property (weak, nonatomic) UserManager* manager;
@end
