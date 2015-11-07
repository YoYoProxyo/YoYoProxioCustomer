//
//  SmallNearbyTableViewCell.h
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYPItem.h"
@interface SmallNearbyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *item;
@property (weak, nonatomic) IBOutlet UILabel *cost;
@property (weak, nonatomic) IBOutlet UIImageView *image;

-(void) setNearable:(YYPItem*) nearable;

@end
