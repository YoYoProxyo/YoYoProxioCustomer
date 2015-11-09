//
//  YYPItem.h
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <EstimoteSDK/EstimoteSDK.h>
#import <UIKit/UIKit.h>

@interface YYPItem : NSObject
@property (strong, nonatomic) NSString* manufacturer;
@property (strong, nonatomic) NSString* itemType;
@property (strong, nonatomic) NSString* price;
@property (strong, nonatomic) NSString* size;
@property (strong, nonatomic) NSNumber* beaconId;
@property (strong, nonatomic) UIImage* image;
@property NSInteger strength;

+(YYPItem*) itemWithBeacon:(CLBeacon*) beacon;
+(YYPItem*) nilItem;
+(YYPItem*) dress ;
@end
