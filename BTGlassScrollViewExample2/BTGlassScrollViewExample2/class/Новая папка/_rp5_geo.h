//
//  _rp5_geo.h
//  BTGlassScrollViewExample2
//
//  Created by ClevMind on 12.01.15.
//  Copyright (c) 2015 Byte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface _rp5_geo : NSObject <CLLocationManagerDelegate>
{
    CLLocationManager *manager;
    CLGeocoder *geoCoder;
    CLPlacemark *placemark;
}
- (id)init;
@end
