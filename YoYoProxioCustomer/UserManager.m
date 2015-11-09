//
//  UserManager.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 08/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager
@synthesize user = _user;
@synthesize pusher = _pusher;

+(UserManager*) newManager {
    UserManager* manager = [[UserManager alloc] init];
    manager.user = [User newUser];
    manager.pusher = [[PusherController alloc] init];
    [manager.pusher initialisePusher];
    return manager;
}

@end
