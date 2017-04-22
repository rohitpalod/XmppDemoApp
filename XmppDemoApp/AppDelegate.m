//
//  AppDelegate.m
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import "AppDelegate.h"
#import "UserDefaultsManager.h"
#import "XMPPManager.h"
@interface AppDelegate ()
//{
//    XMPPStream *xmppStream;
//    NSString *password;
//}
//- (void)setupStream;
//- (void)goOnline;
//- (void)goOffline;


@end

@implementation AppDelegate
//
//@synthesize _chatDelegate, _messageDelegate;
//@synthesize xmppStream = xmppStream;
//
//- (void)setupStream {
//    xmppStream = [[XMPPStream alloc] init];
// 
//    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
//}
//
//- (void)goOnline {
//    XMPPPresence *presence = [XMPPPresence presence];
//    [[self xmppStream] sendElement:presence];
//}
//
//- (void)goOffline {
//    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
//    [[self xmppStream] sendElement:presence];
//}
//- (void)disconnect {
//    
//    [self goOffline];
//    [xmppStream disconnect];
//    
//}
//- (BOOL)connect {
//    
//    [self setupStream];
//    
//    NSString *jabberID = [[UserDefaultsManager sharedInstance]getUserId];
//    NSString *myPassword = [[UserDefaultsManager sharedInstance]getPassword];;
//    
//    if (![xmppStream isDisconnected]) {
//        return YES;
//    }
//    
//    if (jabberID == nil || myPassword == nil) {
//        
//        return NO;
//    }
//    
//    [xmppStream setMyJID:[XMPPJID jidWithString:jabberID]];
//    xmppStream.hostName = @"192.168.1.40";
//    xmppStream.hostPort = 5222;
//    password = myPassword;
//    
//    NSError *error = nil;
//    // [xmppStream oldSchoolSecureConnectWithTimeout:20000 error:&error]
//    if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error])
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
//                                                            message:[NSString stringWithFormat:@"Can't connect to server %@", [error localizedDescription]]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//        
//        return NO;
//    }
//    
//    return YES;
//}
//
//- (void)xmppStreamDidConnect:(XMPPStream *)sender {
//    
//    // connection to the server successful
//    isOpen = YES;
//    NSError *error = nil;
//    [[self xmppStream] authenticateWithPassword:password error:&error];
//    
//    
//}
//
//- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
//    
//    // authentication successful
//    [self goOnline];
//    
//}
//
//
//- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message {
//    
//    // message received
//    NSString *msg = [[message elementForName:@"body"] stringValue];
//    NSString *from = [[message attributeForName:@"from"] stringValue];
//    
//    NSMutableDictionary *m = [[NSMutableDictionary alloc] init];
//    [m setObject:msg forKey:@"msg"];
//    [m setObject:from forKey:@"sender"];
//    
//    [self._messageDelegate newMessageReceived:m];
//   
//    
//    
//}
//
//- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence {
//    
//    NSString *presenceType = [presence type]; // online/offline
//    NSString *myUsername = [[sender myJID] user];
//    NSString *presenceFromUser = [[presence from] user];
//    
//    if (![presenceFromUser isEqualToString:myUsername]) {
//        
//        if ([presenceType isEqualToString:@"available"]) {
//            
//            [self._chatDelegate newBuddyOnline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"localhost"]];
//            
//        } else if ([presenceType isEqualToString:@"unavailable"]) {
//            
//            [self._chatDelegate buddyWentOffline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"localhost"]];
//            
//        }
//        
//    }
//    // a buddy went offline/online
//    
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
  //  [[IQKeyboardManager sharedManager] setEnable:true];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    [[XMPPManager sharedInstance] disconnect];
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[XMPPManager sharedInstance] connect];
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
