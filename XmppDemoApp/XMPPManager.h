//
//  XMPPManager.h
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDefaultsManager.h"
#import "Constants.h"
@import XMPPFramework;

@class  ChatVC;

@protocol ChatDelegate

- (void)newBuddyOnline:(NSString *)buddyName;
- (void)buddyWentOffline:(NSString *)buddyName;
- (void)didDisconnect;

@end

@protocol MessageDelegate

- (void)newMessageReceived:(NSDictionary *)messageContent;

@end


@interface XMPPManager : NSObject{
BOOL isOpen;

NSObject  * _chatDelegate;
NSObject  * _messageDelegate;
}

@property (nonatomic, strong) id  _chatDelegate;
@property (nonatomic, strong) id  _messageDelegate;
@property (nonatomic, readonly) XMPPStream *xmppStream;

+(XMPPManager *)sharedInstance;
- (BOOL)connect;

- (void)disconnect;

-(void)addUserWithJID:(XMPPJID *)jid andNickName:(NSString *)nickName;

@end
