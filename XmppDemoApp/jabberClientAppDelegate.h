//
//  jabberClientAppDelegate.h
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XMPP.h"

@class ChatVC;

@interface jabberClientAppDelegate : NSObject  {
    
    UIWindow *window;
    ChatVC *viewController;
    
    XMPPStream *xmppStream;
    NSString *password;
    BOOL isOpen;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ChatVC *viewController;

@property (nonatomic, readonly) XMPPStream *xmppStream;

- (BOOL)connect;
- (void)disconnect;

@end
