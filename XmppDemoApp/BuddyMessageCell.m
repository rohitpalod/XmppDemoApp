//
//  BuddyMessageCell.m
//  XmppDemoApp
//
//  Created by Rohit palod on 22/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import "BuddyMessageCell.h"

@implementation BuddyMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cellView.layer.cornerRadius = 15;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellData:(NSDictionary *)cellData{


    self.messageField.text = [cellData objectForKey:MESSAGES];
    self.nameField.text = [cellData objectForKey:SENDER];
    self.timeField.text = [cellData objectForKey:TIME];
}
@end
