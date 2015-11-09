//
//  StatusMessage.h
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 08/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "YYPItem.h"

@interface StatusMessage : NSObject
@property (strong, nonatomic) NSString* action;
@property (strong, nonatomic) User* user;
@property (strong, nonatomic) YYPItem* item;
@property (strong, nonatomic) NSString* arg1;
@property (strong, nonatomic) NSString* arg2;

-(NSDictionary*) asDict;
+(StatusMessage*) action:(NSString*) action withUser:(User*) user andObject:(YYPItem*) item;
@end
