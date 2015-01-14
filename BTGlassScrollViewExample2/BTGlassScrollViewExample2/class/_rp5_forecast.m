//
//  _rp5_forecast.m
//  rp5-mobile
//
//  Created by ClevMind on 23.09.14.
//  Copyright (c) 2014 ClevMind. All rights reserved.
//

#import "_rp5_forecast.h"
#import "../AppDelegate.h"
#import "_rp5_settings.h"

#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define WEATHER_NOW [NSURL URLWithString:@"http://utc.rp5.local/rp5android/weather.php?q=174&api_key=3"]

@interface _rp5_forecast ()

@end

@implementation _rp5_forecast
@synthesize DATA = _DATA;
//@synthesize RAM = _RAM;
@synthesize filemanager;


- (id)init {
    self = [super init];
    
    if (self) {
        filemanager = [NSFileManager defaultManager];
    }
    
    return self;
}

- (void)getWeather:(NSString*)date
{
    /* 
     *  СЕЙЧАС
     */
   // _RAM = RAM;
    
    if([date isEqualToString:@"NOW"]) {
        #ifdef RP5_DEBUG
            NSLog(@"NOW");
        #endif
     AppDelegate *DELEGATE= (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        dispatch_async(kBgQueue, ^{
            NSData* data = [NSData dataWithContentsOfURL:WEATHER_NOW];
            [DELEGATE performSelectorOnMainThread:@selector(weatherUpdataNow:)
                                   withObject:data waitUntilDone:YES];
        });
        
    }
}

- (void)readResult:(NSData *)responseData {
    NSError* error;
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          options:kNilOptions
                          error:&error];
    
    if(error && ![error isKindOfClass:[NSNull class]]) {
        NSLog(@"Ошибка в подключении!Проверьте соединение");
        exit(1);
    }
    
   // [_RAM.oStartViewController showResult:json];
    

}

- (BOOL)deleteForecast {
    if(![self ifExistForecast]) {
        return false;
    } else {
        if (![filemanager removeItemAtPath:[NSString stringWithFormat:@"%@%@", get_path(), FORECAST_PLIST] error:nil]) {
#ifdef RP5_DEBUG
            NSLog(@"FORECAST FILE NOT DELETED!");
#endif
            return false;
        }
        else {
#ifdef RP5_DEBUG
            NSLog(@"FORECAST FILE DELETED!");
#endif
            return true;
        }
    }
}

- (BOOL)saveForecast:(NSMutableDictionary*)FORECAST {
    

        NSMutableDictionary *Forecast = [NSMutableDictionary new];
        
        [Forecast setObject:FORECAST        forKey:@"town0"];
        
        NSMutableData *data = [[NSMutableData alloc] init];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
        [archiver encodeObject:Forecast forKey:@"FORECAST"];
        [archiver finishEncoding];
        
        return [filemanager createFileAtPath:[NSString stringWithFormat:@"%@%@", get_path(), FORECAST_PLIST]
                                    contents: data
                                  attributes:nil];
    
}

- (NSMutableDictionary*)getForecastTown:(NSString*)Town {
    if([self ifExistForecast]) {
        NSData *data = [[NSMutableData alloc] initWithContentsOfFile:[NSString stringWithFormat:@"%@%@", get_path(), FORECAST_PLIST]];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSMutableDictionary *FORECAST = [unarchiver decodeObjectForKey:@"FORECAST"];
        [unarchiver finishDecoding];
        
        
        
        for(id key in FORECAST) {
            id value = [FORECAST objectForKey:key];
            
            if([[value objectForKey:@"town_name"] isEqualToString:Town]) {
                return [value objectForKey:@"weather_now"];
            }
        }
        
        //NSLog(@"!!!!%@",[temp objectForKey:@"town_name"]);
        
        return false;
    } else
        return false;
}

- (BOOL)ifExistForecast{
    
    if ([filemanager fileExistsAtPath: [NSString stringWithFormat:@"%@%@", get_path(), FORECAST_PLIST] ] == YES) {
    #ifdef RP5_DEBUG
        NSLog(@"FORECAST_PLIST FILE EXIST!");
    #endif
        return true;
    } else {
    #ifdef RP5_DEBUG
        NSLog(@"FORECAST_PLIST FILE NOT EXIST!");
    #endif
        return false;
    }
}

@end
