//
//  PusherController.h
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 08/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatusMessage.h"
@interface PusherController : NSObject
-(void) initialisePusher;

-(void) sendMessage:(StatusMessage*) message;
-(void) sendSale:(StatusMessage*) message;
@end
