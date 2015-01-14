//
//  _rp5_geo.h
//  BTGlassScrollViewExample2
//
//  Created by ClevMind on 13.01.15.
//  Copyright (c) 2015 Byte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface _rp5_geo : UIViewController <CLLocationManagerDelegate>
- (id)init;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
@end
