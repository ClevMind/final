//
//  _rp5_functions.m
//  rp5-mobile
//
//  Created by ClevMind on 26.09.14.
//  Copyright (c) 2014 ClevMind. All rights reserved.
//

#import "_rp5_functions.h"

void rp5_alert(NSString *header, NSString *mess, UIViewController *delegate,  NSInteger cancelButtonIndex, NSArray *otherButtons, NSInteger tag) {
    
    /*
     !<UIAlertViewDelegate>!
     
     - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
     NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
     NSLog(@"INDEX:%@", title);
     }
     */
    
    UIAlertView* alert = [[UIAlertView alloc] init];
    
    [alert setTitle:header];
    [alert setMessage:mess];
    [alert setCancelButtonIndex:cancelButtonIndex];
    [alert setTag:tag];
    
    
    for(NSString *butt_name in otherButtons) {
        [alert addButtonWithTitle:butt_name];
    }
    

    [alert show];
    // [alert release];
    
}


NSString* get_path() {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [NSString stringWithFormat:@"%@/", [paths objectAtIndex:0]];
}

NSString* low_and_cap(NSString *str) {
    return [[str lowercaseString] uppercaseString];
}