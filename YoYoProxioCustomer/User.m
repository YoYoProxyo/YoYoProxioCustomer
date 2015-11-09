//
//  User.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 08/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "User.h"
#import <UIKit/UIKit.h>

@implementation User
@synthesize username = _username;
@synthesize loggedIn = _loggedIn;

+(User*) newUser {
    NSString *uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    User* user = [[User alloc] init];
    
    user.username = [NSString stringWithFormat:@"anonymous_%@", uniqueIdentifier];
    
    user.loggedIn = NO;
    
    return user;
}
@end
