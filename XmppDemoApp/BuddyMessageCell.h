//
//  BuddyMessageCell.h
//  XmppDemoApp
//
//  Created by Rohit palod on 22/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"

@interface BuddyMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *cellView;
@property (weak, nonatomic) IBOutlet UITextField *messageField;
@property (weak, nonatomic) IBOutlet UITextField *timeField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *seperaterView;

-(void)setCellData:(NSDictionary *)cellData;
@end
