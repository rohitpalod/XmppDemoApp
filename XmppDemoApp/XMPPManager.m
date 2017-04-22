//
//  XMPPManager.m
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import "XMPPManager.h"
#import <XMPPFramework/XMPPFramework.h>

@interface XMPPManager ()
{
    XMPPStream *xmppStream;
    NSString *password;
    XMPPRoster * xmppRoster;
    XMPPRosterCoreDataStorage * xmppRosterStorage;
    XMPPReconnect * xmppReconnect;
}

- (void)setupStream;
- (void)goOnline;
- (void)goOffline;


@end

@implementation XMPPManager
@synthesize _chatDelegate, _messageDelegate;
@synthesize xmppStream = xmppStream;


+(XMPPManager*)sharedInstance{
    static dispatch_once_t pred;
    static XMPPManager * sharedObject = nil;
    dispatch_once(&pred, ^{
        sharedObject = [XMPPManager new];
      //  [sharedObject setupStream];
    });
    return sharedObject;
}

- (void)setupStream {
    xmppStream = [[XMPPStream alloc] init];
    
    [xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    
    xmppRosterStorage = [XMPPRosterCoreDataStorage sharedInstance];
    xmppRosterStorage.autoRemovePreviousDatabaseFile = NO;
    xmppRoster = [[XMPPRoster alloc] initWithRosterStorage:xmppRosterStorage];
    
    xmppRoster.autoFetchRoster = YES;
    xmppRoster.autoAcceptKnownPresenceSubscriptionRequests = YES;
    xmppRoster.autoClearAllUsersAndResources = NO;
    xmppReconnect = [[XMPPReconnect alloc]init];
    [xmppReconnect activate:xmppStream];
    [xmppReconnect addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [xmppRoster  activate:xmppStream];
    [xmppRoster addDelegate:self delegateQueue:dispatch_get_main_queue()];

}

- (void)goOnline {
    XMPPPresence *presence = [XMPPPresence presence];
    [[self xmppStream] sendElement:presence];
}

- (void)goOffline {
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    [[self xmppStream] sendElement:presence];
}

- (void)disconnect {
    
    [self goOffline];
    [xmppStream disconnectAfterSending];
    
}

- (BOOL)connect {
    
    [self setupStream];
    
    NSString *jabberID = [[UserDefaultsManager sharedInstance]getUserId];
    NSString *myPassword = [[UserDefaultsManager sharedInstance]getPassword];;
    
    if (![xmppStream isDisconnected]) {
        return YES;
    }
    
    if (jabberID == nil || myPassword == nil) {
        
        return NO;
    }
    
    [xmppStream setMyJID:[XMPPJID jidWithString:jabberID]];
    xmppStream.hostName = HOSTNAME_WIFI;
    xmppStream.hostPort = 5222;
    password = myPassword;
    
    NSError *error = nil;

    if (![xmppStream connectWithTimeout:XMPPStreamTimeoutNone error:&error])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:[NSString stringWithFormat:@"Can't connect to server %@", [error localizedDescription]]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
        return NO;
    }
    
    return YES;
}


#pragma mark- XmppStream Delegate
- (void)xmppStreamDidConnect:(XMPPStream *)sender {
    
    // connection to the server successful
    isOpen = YES;
    NSError *error = nil;
    [[self xmppStream] authenticateWithPassword:password error:&error];
    
    
}

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender {
    
    // authentication successful
    [self goOnline];
    
}

- (void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message {
    
    // message received
    NSString *msg = [[message elementForName:@"body"] stringValue];
    NSString *from = [[message attributeForName:@"from"] stringValue];
    
    if(msg !=nil && from !=nil){
        
        NSMutableDictionary *msgDict = [[NSMutableDictionary alloc] init];
        [msgDict setObject:msg forKey:@"msg"];
        [msgDict setObject:from forKey:@"sender"];
        [self._messageDelegate newMessageReceived:msgDict];
    }
    
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence {
    
    NSString *presenceType = [presence type]; // online/offline
    NSString *myUsername = [[sender myJID] user];
    NSString *presenceFromUser = [[presence from] user];
    
    if (![presenceFromUser isEqualToString:myUsername]) {
        
        if ([presenceType isEqualToString:@"available"]) {
            
            [self._chatDelegate newBuddyOnline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"localhost"]];
            
        } else if ([presenceType isEqualToString:@"unavailable"]) {
            
            [self._chatDelegate buddyWentOffline:[NSString stringWithFormat:@"%@@%@", presenceFromUser, @"localhost"]];
            
        }
        
    }
    
}


#pragma mark - XMPPRoster Delegate
- (void)xmppRoster:(XMPPRoster *)sender didReceivePresenceSubscriptionRequest:(XMPPPresence *)presence{

    [xmppRoster acceptPresenceSubscriptionRequestFrom:presence.from andAddToRoster:YES];

}

-(void)addUserWithJID:(XMPPJID *)jid andNickName:(NSString *)nickName{
    [xmppRoster addUser:jid withNickname:nickName];
}

#pragma mark - xmppReconnetDelegate
- (void)xmppReconnect:(XMPPReconnect *)sender didDetectAccidentalDisconnect:(SCNetworkConnectionFlags)connectionFlags{

}
- (BOOL)xmppReconnect:(XMPPReconnect *)sender shouldAttemptAutoReconnect:(SCNetworkConnectionFlags)connectionFlags{
    return true;
}



@end
