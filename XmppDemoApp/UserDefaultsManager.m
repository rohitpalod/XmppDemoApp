//
//  UserDefaultsManager.m
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import "UserDefaultsManager.h"

@implementation UserDefaultsManager

+(instancetype)sharedInstance{
    static UserDefaultsManager *instance=nil;
    
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [UserDefaultsManager new];
        }
    }
    return instance;
}

-(void)setUserId:(NSString *)userID{
    [[NSUserDefaults standardUserDefaults]setObject:userID forKey:USER_ID];
}
-(NSString *)getUserId{
   return [[NSUserDefaults standardUserDefaults]objectForKey:USER_ID];
}

-(void)setPassword:(NSString *)password{
    [[NSUserDefaults standardUserDefaults]setObject:password forKey:PASSWORD];
}

-(NSString *)getPassword{
    return [[NSUserDefaults standardUserDefaults]objectForKey:PASSWORD];
}

@end
