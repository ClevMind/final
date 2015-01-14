//
//  _rp5_NET.m
//  rp5-mobile
//
//  Created by ClevMind on 03.10.14.
//  Copyright (c) 2014 ClevMind. All rights reserved.
//

#import "_rp5_NET.h"


@implementation _rp5_NET
@synthesize reachability;
@synthesize isOFF;
@synthesize isWIFI;
@synthesize IsWWAN;


- (BOOL)isReachable {
    isOFF = false;
    return true;
}

- (BOOL)isUnreachable {
    isOFF = true;
     NSLog(@"!NO LAN!");
           return true;
}

- (BOOL)isReachableViaWWAN {
    isOFF = false;
    IsWWAN = true;
    NSLog(@"!WWAN!");
       return true;
}

- (BOOL)isReachableViaWiFi {
    isOFF = false;
    isWIFI = true;
       NSLog(@"!WIFI!");
             return true;
}

- (id)init {
    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}

@end
