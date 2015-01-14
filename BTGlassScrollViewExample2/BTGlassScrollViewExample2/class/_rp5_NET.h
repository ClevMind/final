//
//  _rp5_NET.h
//  rp5-mobile
//
//  Created by ClevMind on 03.10.14.
//  Copyright (c) 2014 ClevMind. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "../web/Reachability.h"

@interface _rp5_NET : NSObject

@property (retain, nonatomic) Reachability *reachability;
@property BOOL isOFF;
@property BOOL isWIFI;
@property BOOL IsWWAN;

- (id)init;
- (BOOL)isReachable;
- (BOOL)isUnreachable;
- (BOOL)isReachableViaWWAN;
- (BOOL)isReachableViaWiFi;

@end
