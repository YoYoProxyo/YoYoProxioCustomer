//
//  YYPItem.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "YYPItem.h"

@implementation YYPItem
@synthesize manufacturer = _manufacturer;
@synthesize size = _size;
@synthesize beaconId = _beaconId;
@synthesize itemType = _itemType;
@synthesize image = _image;

+(YYPItem*) itemWithBeacon:(CLBeacon*) beacon {
    // Should be referring to item
    YYPItem* item = [[YYPItem alloc] init];
    if ([beacon.minor isEqualToNumber:@3720] || [beacon.minor isEqualToNumber:@58632]) {
        item.manufacturer = @"yoyo-prox.io";
        item.beaconId = beacon.minor;
        item.itemType = @"fixed";
        item.strength = beacon.rssi;
        item.price = @"0.00";
        return item;
    }

    return [YYPItem simpleBeacon:beacon];
}

+(YYPItem*) nilItem {
    YYPItem* item = [[YYPItem alloc] init];
    item.beaconId = [NSNumber numberWithInt:0];
    item.manufacturer = @"";
    item.itemType = @"";
    item.size = @"";
    item.price = @"";
    return item;
}

+(YYPItem*) dress {
    YYPItem* item = [[YYPItem alloc] init];
    item.beaconId = [NSNumber numberWithInt:18810];
    item.manufacturer = @"River Island";
    item.itemType = @"dress";
    item.size = @"12";
    item.price = @"29.99";
    item.strength = 100;
        item.image = [YYPItem imageForType:item.itemType];
    return item;
}

+(YYPItem*) simpleBeacon:(CLBeacon*) beacon {
    YYPItem* item = [[YYPItem alloc] init];
    item.beaconId = beacon.minor;
    
    
    
    if ([beacon.minor isEqualToNumber:@18810]) {
        item.itemType = @"dress";
        item.manufacturer = @"River Island";
        item.price = @"2500";
    } else if([beacon.minor isEqualToNumber:@21023]) {
        item.itemType = @"shirt";
        item.manufacturer = @"Calvin Klein";
        item.price = @"20";
    } else if([beacon.minor isEqualToNumber:@33106]) {
        item.itemType = @"pants";
        item.manufacturer = @"Tighty Whitey";
        item.price = @"5";
    } else if([beacon.minor isEqualToNumber:@3720]) {
        item.itemType = @"fixed";
    }    else {
        int val = [beacon.minor intValue] % 3;
        if (val == 0) {
            item.itemType = @"shoes";
            item.manufacturer = @"Sketchers";
            item.price = @"35";
        } else if (val == 1) {
            item.itemType = @"trousers";
            item.manufacturer = @"Dockers";
            item.price = @"33.50";
        } else if (val == 2) {
            item.itemType = @"bra";
            item.manufacturer = @"Adidas Sports";
            item.price = @"24.99";
        }
    }
    item.strength = beacon.rssi;
    item.image = [YYPItem imageForType:item.itemType];
    item.size = @"Large";
    return item;
}
+(UIImage*) imageForType:(NSString*) imageType {
    return [UIImage imageNamed:imageType];
}


@end
