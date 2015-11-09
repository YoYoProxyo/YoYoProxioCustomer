//
//  User.h
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 08/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (strong, nonatomic) NSString* username;
@property BOOL loggedIn;

+(User*) newUser;

@end
