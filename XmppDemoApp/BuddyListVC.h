//
//  BuddyListVC.h
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ChatVC.h"
#import "XMPP.h"
#import "XMPPManager.h"
#import "AddBuddyVC.h"
@interface BuddyListVC : UIViewController<UITableViewDelegate,UITableViewDataSource,ChatDelegate>
@property (weak, nonatomic) IBOutlet UITableView *buddyTable;


@end
