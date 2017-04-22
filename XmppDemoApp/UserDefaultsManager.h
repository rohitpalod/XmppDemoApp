//
//  UserDefaultsManager.h
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
@interface UserDefaultsManager : NSObject

+(instancetype)sharedInstance;
-(NSString *)getUserId;
-(void)setUserId:(NSString *)userID;
-(void)setPassword:(NSString *)password;
-(NSString *)getPassword;
@end
