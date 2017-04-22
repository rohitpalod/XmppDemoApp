//
//  LoginVC.m
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import "LoginVC.h"
#import "UserDefaultsManager.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginCllick:(UIButton *)sender {
    if([self validate]){
        [[UserDefaultsManager sharedInstance]setUserId:self.userIdField.text];
        [[UserDefaultsManager sharedInstance]setPassword:self.passwordField.text];
        
        [self dismissViewControllerAnimated:false completion:nil];
    }
    else{
        [self showAlertWithMesssage:@"Please fill all details" andTitle:@"Alert"];
    }
}

- (IBAction)cancelClick:(UIButton *)sender {
    
    [self dismissViewControllerAnimated:false completion:nil];
}

-(BOOL)validate{
    
    return ([self validateUserID:self.userIdField.text] && [self validatePassword:self.passwordField.text]);
}

-(BOOL)validateUserID:(NSString *)userId{
    return userId.length >0 ? true:false;
}

-(BOOL)validatePassword:(NSString *)pass{
    
    return pass.length >0 ? true: false;
}

-(void)showAlertWithMesssage:(NSString *)message andTitle:(NSString *)title{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
