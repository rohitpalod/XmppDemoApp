//
//  MessageCell.h
//  XmppDemoApp
//
//  Created by Rohit palod on 22/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell


@property (nonatomic,strong) UILabel *senderAndTimeLabel;
@property (nonatomic,strong) UITextView *messageContentView;
@property (nonatomic,strong) UIImageView *bgImageView;



@end
