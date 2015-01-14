//
//  AppDelegate.h
//  BTGlassScrollViewExample2
//
//  Created by Byte on 1/23/14.
//  Copyright (c) 2014 Byte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BTGlassScrollViewController.h"
#import "class/_rp5_settings.h"
#import "web/Reachability.h"
#import "class/_rp5_NET.h"
#import "class/_rp5_forecast.h"
#import "class/_rp5_geo.h"

@interface AppDelegate : UIResponder <UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) Reachability *reachability;
@property (nonatomic, retain) NSTimer *updateTimer;
@property _rp5_NET *NET;
@property _rp5_forecast *FORECAST;
@property NSDate *date;
@property NSDateFormatter *dateFormat;
@property NSString *dateString;

- (id)init;
- (void)weatherUpdataNow:(NSData *)responseData;
- (void) Update;
- (void) updateTime;
- (void) NotifyMe;

@end
