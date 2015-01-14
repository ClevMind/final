//
//  _rp5_forecast.h
//  rp5-mobile
//
//  Created by ClevMind on 23.09.14.
//  Copyright (c) 2014 ClevMind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "../_rp5_functions.h"

//@class _rp5_ram;
//@class AppDelegate;

@interface _rp5_forecast : NSObject
@property NSDictionary* DATA;
@property NSMutableArray *WEATHER_NOW;
//@property _rp5_ram *RAM;
@property NSFileManager *filemanager;

- (id)init;
- (void)getWeather:(NSString*)date;
- (BOOL)deleteForecast;
- (BOOL)saveForecast:(NSMutableDictionary*)FORECAST;
- (BOOL)ifExistForecast;
- (NSMutableDictionary*)getForecastTown:(NSString*)Town;
@end