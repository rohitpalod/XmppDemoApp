//
//  AddBuddyVC.m
//  XmppDemoApp
//
//  Created by Rohit palod on 21/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import "AddBuddyVC.h"
#import "XMPPManager.h"
@import XMPPFramework;
@interface AddBuddyVC ()

@end

@implementation AddBuddyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)AddBtnClick:(UIButton *)sender {
    
    if(self.accountNameField.text !=nil){
        XMPPJID * jid = [XMPPJID jidWithString:self.accountNameField.text];
        [[XMPPManager sharedInstance]addUserWithJID:jid andNickName:self.nickNameField.text];
    }
    
    [self dismissViewControllerAnimated:false completion:nil];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}


@end
