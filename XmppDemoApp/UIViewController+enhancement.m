//
//  UIViewController+enhancement.m
//  XmppDemoApp
//
//  Created by Rohit palod on 22/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import "UIViewController+enhancement.h"

@implementation UIViewController (enhancement)

-(void)showAlertWithAlertMessage:(NSString *)message andTitle:(NSString *)title{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
