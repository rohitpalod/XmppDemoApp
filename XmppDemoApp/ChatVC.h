//
//  ChatVC.h
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "XMPPManager.h"
#import "MyMessageCell.h"
#import "BuddyMessageCell.h"
@interface ChatVC : UIViewController<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,MessageDelegate>
@property (weak, nonatomic) IBOutlet UITableView *chatTable;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UIView *messageView;

@property (nonatomic,retain) NSString *chatWithUser;


@end
