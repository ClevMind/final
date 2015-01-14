//
//  _rp5_geo.m
//  BTGlassScrollViewExample2
//
//  Created by ClevMind on 12.01.15.
//  Copyright (c) 2015 Byte. All rights reserved.
//

#import "_rp5_geo.h"

@implementation _rp5_geo


- (id)init {
    self = [super init];
    
    if (self) {
        manager = [CLLocationManager init];
        geoCoder = [CLGeocoder init];
        manager.delegate = self;
        manager.desiredAccuracy = kCLLocationAccuracyBest;
        [manager startUpdatingLocation];
    }
    
    
    
    return self;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Ошибка в получении местоположения%@", error);
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSLog(@"%@", [locations lastObject]);
}

@end
