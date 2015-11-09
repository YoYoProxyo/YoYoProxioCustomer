//
//  UserManager.h
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 08/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "PusherController.h"

@interface UserManager : NSObject
@property (strong, nonatomic) User* user;
@property (strong, nonatomic) PusherController* pusher;
+(UserManager*) newManager;

@end
