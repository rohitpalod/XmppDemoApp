//
//  AddBuddyVC.h
//  XmppDemoApp
//
//  Created by Rohit palod on 21/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddBuddyVC : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountNameField;

@property (weak, nonatomic) IBOutlet UITextField *nickNameField;

@end
