//
//  _rp5_settings.h
//  rp5-mobile
//
//  Created by ClevMind on 29.09.14.
//  Copyright (c) 2014 ClevMind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/*
 *
 * DEBUG OR RELEASE
 *
 */
#define RP5_DEBUG TRUE

/******************************/

/*   DEFINE LIST     */

#define SETTINGS_PLIST @"RP5_SETUP.plist"
#define FORECAST_PLIST @"RP5_FORECAST.plist"
#define UPDATE_INTERVAL 60.0f



@interface _rp5_settings : NSObject
@property NSMutableDictionary *LANGUAGES;
@property NSMutableDictionary *UNITS;

-(id)init;
- (void)setLanguages;
- (void)setUnits;
@end
