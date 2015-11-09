//
//  PusherController.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 08/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "PusherController.h"
#import <Pusher/Pusher.h>

@interface PusherController() <PTPusherDelegate>
@property (strong, nonatomic) NSString* channelName;
@property (strong, nonatomic) PTPusher* client;
@property (strong, nonatomic) PTPusherChannel* channel;
@end

@implementation PusherController

-(void) initialisePusher
{
    
    // self.client is a strong instance variable of class PTPusher
    self.client = [PTPusher pusherWithKey:@"4b524aba332c3314b072"
                                 delegate:self
                                encrypted:NO];
    self.client.authorizationURL = [NSURL URLWithString:@"https://vast-fortress-8166.herokuapp.com/pusher/auth"];
    self.channelName = @"yoyoproxio";
    
    [self.client connect];
    
}

-(void) pusher:(PTPusher *)pusher connectionDidConnect:(PTPusherConnection *)connection {
    NSLog(@"Connected to %@", connection.URL);
    self.channel = [self.client subscribeToPrivateChannelNamed:self.channelName];
}
-(void) pusher:(PTPusher *)pusher connection:(PTPusherConnection *)connection failedWithError:(NSError *)error
{
    NSLog(@"Failed to connect to %@ with error %@", connection.URL, error);
}
-(void) pusher:(PTPusher *)pusher didSubscribeToChannel:(PTPusherChannel *)channel
{
    NSLog(@"Subscribed to %@", channel.name);
}
-(void) pusher:(PTPusher *)pusher didFailToSubscribeToChannel:(PTPusherChannel *)channel withError:(NSError *)error
{
    NSLog(@"Subscribe to channel %@ failed with error %@", channel.name, error);
    
}

-(void) sendMessage:(StatusMessage*) message {
    [self.client sendEventNamed:@"client-scan"
                           data:message.asDict
                        channel:self.channel.name];
}
-(void) sendSale:(StatusMessage*) message {
    [self.client sendEventNamed:@"client-sale"
                           data:message.asDict
                        channel:self.channel.name];
}
@end
