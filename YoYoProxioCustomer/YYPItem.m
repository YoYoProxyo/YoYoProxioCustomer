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
    
    return [YYPItem simpleBeacon:beacon];
}

+(YYPItem*) simpleBeacon:(CLBeacon*) beacon {
    YYPItem* item = [[YYPItem alloc] init];
    item.beaconId = beacon.minor;
    
    if ([beacon.minor isEqualToNumber:@18810]) {
        item.itemType = @"dress";
        item.manufacturer = @"Donna Karan";
        item.price = @"2500";
    } else if([beacon.minor isEqualToNumber:@21023]) {
        item.itemType = @"shirt";
        item.manufacturer = @"Calvin Klein";
        item.price = @"20";
    } else if([beacon.minor isEqualToNumber:@33106]) {
        item.itemType = @"pants";
        item.manufacturer = @"Tighty Whitey";
        item.price = @"5";
    } else {
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
    item.image = [YYPItem imageForType:item.itemType];
    item.size = @"Large";
    return item;
}
+(UIImage*) imageForType:(NSString*) imageType {
    return [UIImage imageNamed:imageType];
}


@end
