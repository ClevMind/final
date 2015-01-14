//
//  _rp5_functions.h
//  rp5-mobile
//
//  Created by ClevMind on 26.09.14.
//  Copyright (c) 2014 ClevMind. All rights reserved.
//

#ifndef rp5_mobile__rp5_functions_h
#define rp5_mobile__rp5_functions_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

void rp5_alert(NSString *header, NSString *mess, UIViewController *delegate,  NSInteger cancelButtonIndex, NSArray *otherButtons, NSInteger tag);
NSString* get_path();
NSString* low_and_cap(NSString *str);
#endif
