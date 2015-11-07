//
//  SmallNearbyTableViewCell.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "SmallNearbyTableViewCell.h"


@implementation SmallNearbyTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void) setNearable:(YYPItem*) nearable {
    [self.item setText:[NSString stringWithFormat:@"%@ %@", nearable.manufacturer, nearable.itemType]];
    [self.cost setText:[NSString stringWithFormat:@"£%@", nearable.price]];
    [self.image setImage:nearable.image];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
