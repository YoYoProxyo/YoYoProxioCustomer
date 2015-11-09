//
//  StatusMessage.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 08/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "StatusMessage.h"

@implementation StatusMessage
@synthesize action = _action;
@synthesize user = _user;
@synthesize item = _item;
@synthesize arg1 = _arg1;
@synthesize arg2 = _arg2;

-(NSDictionary*) asDict {
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionaryWithCapacity:10];
    [dictionary setObject:self.action forKey:@"action"];
    [dictionary setObject:self.user.username forKey:@"user"];
    [dictionary setObject:self.item.beaconId forKey:@"beacon"];
    [dictionary setObject:self.item.itemType forKey:@"itemtype"];
    [dictionary setObject:self.item.manufacturer forKey:@"manufacturer"];
    [dictionary setObject:self.item.price forKey:@"price"];
    if (self.arg1) {
        [dictionary setObject:self.arg1 forKey:@"arg1"];
    }
    if (self.arg2) {
        [dictionary setObject:self.arg1 forKey:@"arg2"];
    }
    
    return dictionary;
}
+(StatusMessage*) action:(NSString*) action withUser:(User*) user andObject:(YYPItem*) item {
    StatusMessage* message = [[StatusMessage alloc] init];
    message.action = action;
    message.user = user;
    message.item = item;
    return message;
}
@end
