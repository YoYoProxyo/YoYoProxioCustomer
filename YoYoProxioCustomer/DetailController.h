//
//  DetailController.h
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYPItem.h"
#import "UserManager.h"

@interface DetailController : UIViewController
@property (weak, nonatomic) YYPItem* item;
@property (weak,  nonatomic) UserManager* manager;
@end
