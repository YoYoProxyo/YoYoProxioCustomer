//
//  BrowseController.m
//  YoYoProxioCustomer
//
//  Created by Tom Ridd on 07/11/2015.
//  Copyright © 2015 Tom Ridd. All rights reserved.
//

#import "BrowseController.h"
#import <EstimoteSDK/EstimoteSDK.h>
#import "YYPItem.h"
#import "SmallNearbyTableViewCell.h"
#import "DetailController.h"
#import "UIImage+animatedGIF.h"
#import "SignInController.h"

@interface BrowseController
 () <UITableViewDataSource, ESTBeaconManagerDelegate>
@property (weak, nonatomic) IBOutlet UIView *scanning;
@property (weak, nonatomic) IBOutlet UIImageView *scanImage;


@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UILabel *mainItem;
@property (weak, nonatomic) IBOutlet UILabel *mainCost;
@property (weak, nonatomic) IBOutlet UILabel *mainSize;
@property (weak, nonatomic) IBOutlet UIButton *scanButton;
@property (weak, nonatomic) IBOutlet UITableView *nearbyTable;

@property (nonatomic, copy)     void (^completion)(CLBeacon *);

@property (nonatomic, assign)   ESTScanType scanType;
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) CLBeaconRegion *region;
@property (nonatomic, strong) NSArray *beaconsArray;

@property (strong, nonatomic) YYPItem* immediate;
@property (strong, nonatomic) NSArray <YYPItem*>* nearby;
@property (weak, nonatomic) IBOutlet UIView *userOffers;
@property (weak, nonatomic) IBOutlet UIView *userSignIn;
@property (weak, nonatomic) IBOutlet UILabel *hiLabel;

@property (strong, nonatomic) YYPItem* nearestFixedBeacon;
@end

@implementation BrowseController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"Bill" withExtension:@"gif"];
//    self.scanImage.image = [UIImage animatedImageWithAnimatedGIFData:[NSData dataWithContentsOfURL:url]];
    
    self.nearby = [[NSArray alloc] init];
    
    [self.nearbyTable setDataSource:self];
    [self.nearbyTable setBackgroundColor:self.view.backgroundColor];
    [self.nearbyTable setSeparatorColor:self.view.backgroundColor];
    
    [self initialiseEstimote];
}

- (void) initialiseEstimote {
    
    self.scanType = ESTScanTypeBeacon;
    self.completion = ^(CLBeacon *beacon) {
        [BrowseController completionHandler:beacon];
    };
}
- (IBAction)logout:(id)sender {
    self.manager.user.loggedIn = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (self.manager.user.loggedIn) {
        [self.hiLabel setText:[NSString stringWithFormat:@"Hi %@", self.manager.user.username]];
        [self.userOffers setHidden:NO];
        [self.userSignIn setHidden:YES];
    } else {
        [self.hiLabel setText:@""];
        [self.userOffers setHidden:YES];
        [self.userSignIn setHidden:NO];
    }
    
    /*
     * Starts looking for Estimote beacons.
     * All callbacks will be delivered to beaconManager delegate.
     */
    if (self.scanType == ESTScanTypeBeacon)
    {
        /*
         * Creates sample region object (you can additionaly pass major / minor values).
         *
         * We specify it using only the ESTIMOTE_PROXIMITY_UUID because we want to discover all
         * hardware beacons with Estimote's proximty UUID.
         */
        self.region = [[CLBeaconRegion alloc] initWithProximityUUID:ESTIMOTE_PROXIMITY_UUID
                                                         identifier:@"EstimoteSampleRegion"];
        
        self.beaconManager = [[ESTBeaconManager alloc] init];
        self.beaconManager.delegate = self;
        
        NSLog(@"Start ranging");
        [self startRangingBeacons];
    }
}

-(void)startRangingBeacons
{
    NSLog(@"%d", [ESTBeaconManager authorizationStatus]);
    
    if ([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        [self.beaconManager requestAlwaysAuthorization];
    }
    else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Access Denied"
                                                        message:@"You have denied access to location services. Change this in app settings."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
    }
    else if([ESTBeaconManager authorizationStatus] == kCLAuthorizationStatusRestricted)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Location Not Available"
                                                        message:@"You have no access to location services."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        
        [alert show];
    }
}



- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    /*
     *Stops ranging after exiting the view.
     */
    [self.beaconManager stopRangingBeaconsInRegion:self.region];
}

#pragma mark - ESTBeaconManager delegate

-(void) beaconManager:(id)manager didStartMonitoringForRegion:(CLBeaconRegion *)region {
    NSLog(@"Starting monitoring for region %@", region.major);
}
- (void)beaconManager:(id)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusNotDetermined && status != kCLAuthorizationStatusDenied )
    {
        [self.beaconManager startRangingBeaconsInRegion:self.region];
    }
}

- (void)beaconManager:(id)manager rangingBeaconsDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    UIAlertView* errorView = [[UIAlertView alloc] initWithTitle:@"Ranging error"
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    
    [errorView show];
}

- (void)beaconManager:(id)manager monitoringDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    UIAlertView* errorView = [[UIAlertView alloc] initWithTitle:@"Monitoring error"
                                                        message:error.localizedDescription
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    
    [errorView show];
}

- (void)beaconManager:(id)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{

    CLBeacon* nearBeacon = nil;
    NSMutableArray <CLBeacon*>* beaconList = [NSMutableArray arrayWithCapacity:10];
    
    for (CLBeacon* beacon in beacons) {
        YYPItem* item = [YYPItem itemWithBeacon:beacon];

        if ([item.itemType isEqualToString:@"fixed"]) {
            if (!self.nearestFixedBeacon) {
                    self.nearestFixedBeacon = item;
                    [self.manager.pusher sendMessage:[StatusMessage action:@"nearby" withUser:self.manager.user andObject:item]];
            } else if (![self.nearestFixedBeacon.beaconId isEqualToNumber:item.beaconId] && self.nearestFixedBeacon.strength < item.strength) {
                self.nearestFixedBeacon = item;
                [self.manager.pusher sendMessage:[StatusMessage action:@"nearby" withUser:self.manager.user andObject:item]];
            }
        } else {
            if (beacon.proximity == CLProximityImmediate) {
                if (nearBeacon) {
                    [beaconList addObject:beacon];
                } else {
                    nearBeacon = beacon;
                }
            } else if (beacon.proximity == CLProximityNear){
                [beaconList addObject:beacon];
            }
        }
    }

    if (nearBeacon) {
        [self setImmediateBeacon:nearBeacon];
    } else {
        [self setNoImmediateBeacon];
    }

    
    
    [self setNearbyList:beaconList];
}
- (IBAction)clickDetailsButton:(id)sender {
    if (self.immediate) {
        [self performSegueWithIdentifier:@"showDetails" sender:self];
    }
}
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[DetailController class]]) {
        DetailController* controller = segue.destinationViewController;
        controller.item = self.immediate;
        controller.manager = self.manager;
    } else if ([segue.destinationViewController isKindOfClass:[SignInController class]]) {
        SignInController* controller = segue.destinationViewController;
        controller.manager = self.manager;
    }
}

-(void) setNoImmediateBeacon {
    [self.scanning setHidden:NO];
}
-(void) setImmediateBeacon:(CLBeacon*) beacon {
    
    YYPItem* item = [YYPItem itemWithBeacon:beacon];
    
    if (!self.immediate || ![item.beaconId isEqualToNumber:self.immediate.beaconId]) {
        StatusMessage* message = [StatusMessage action:@"scan"
                                              withUser:self.manager.user
                                             andObject:item];
        [self.manager.pusher sendMessage:message];
    }
    
    self.immediate = item;
    [self.mainImage setImage:item.image];
    [self.mainItem setText:[NSString stringWithFormat:@"%@ %@", item.manufacturer, item.itemType]];
    [self.mainCost setText:[NSString stringWithFormat:@"£%@", item.price]];
    [self.mainSize setText:[NSString stringWithFormat:@"Size %@", item.size]];
    
    [self.scanning setHidden:YES];
}

-(void) setNearbyList:(NSArray<CLBeacon*>*) beacons {
    NSMutableArray<YYPItem*>* items = [NSMutableArray arrayWithCapacity:10];
    for (CLBeacon* beacon in beacons) {
        [items addObject:[YYPItem itemWithBeacon:beacon]];
    }
    self.nearby = [items sortedArrayUsingComparator:^NSComparisonResult(id a, id b) {
        YYPItem* aItem = (YYPItem*) a;
        YYPItem* bItem = (YYPItem*) b;
        return [[NSNumber numberWithLong:bItem.strength] compare:[NSNumber numberWithLong:aItem.strength]];
    }];
    
    [self.nearbyTable reloadData];
}


+ (void) completionHandler:(CLBeacon*) beacon {
    NSLog(@"%@", beacon);
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.nearby.count;
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SmallNearbyTableViewCell *cell = (SmallNearbyTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"nearby" forIndexPath:indexPath];
    
    [cell setNearable:[self.nearby objectAtIndex:indexPath.row]];
    
    return cell;
}


@end
