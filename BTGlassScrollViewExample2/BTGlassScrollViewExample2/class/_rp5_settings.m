//
//  _rp5_settings.m
//  rp5-mobile
//
//  Created by ClevMind on 29.09.14.
//  Copyright (c) 2014 ClevMind. All rights reserved.
//

#import "_rp5_settings.h"

@implementation _rp5_settings
@synthesize LANGUAGES;
@synthesize UNITS;

- (id)init {
    self = [super init];
    
    if (self) {
        LANGUAGES = [NSMutableDictionary dictionary];
        UNITS     = [NSMutableDictionary dictionary];
        [self setLanguages];
        [self setUnits];
    }
    
    return self;
}

- (void)setLanguages {
    [LANGUAGES setObject:@"Русский"         forKey:@"RU"];
    [LANGUAGES setObject:@"Английский"      forKey:@"EN"];
}

- (void)setUnits {
    [UNITS setObject:@"C, мм, км"         forKey:@"0"];
    [UNITS setObject:@"F, мили"           forKey:@"1"];
}

@end
