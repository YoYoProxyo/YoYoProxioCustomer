//
//  PayController.h
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserManager.h"
#import "YYPItem.h"

@interface PayController : UIViewController
@property (strong, nonatomic) UserManager* manager;
@property (strong, nonatomic) YYPItem* item;
@end
