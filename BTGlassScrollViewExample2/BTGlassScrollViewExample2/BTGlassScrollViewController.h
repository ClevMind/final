//
//  BTGlassScrollViewController.h
//  BTGlassScrollViewExample2
//
//  Created by Byte on 1/23/14.
//  Copyright (c) 2014 Byte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTGlassScrollView.h"
#import <CoreLocation/CoreLocation.h>

@interface BTGlassScrollViewController : UIViewController <CLLocationManagerDelegate>
@property (nonatomic, assign) int index;
@property (nonatomic, strong) BTGlassScrollView *glassScrollView;
- (id)initWithImage:(UIImage *)image;
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation;
@end
