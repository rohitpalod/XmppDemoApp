//
//  BuddyListVC.m
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import "BuddyListVC.h"
#import "UserDefaultsManager.h"
@interface BuddyListVC ()
{
        NSMutableArray * onlineBuddies;
}
@end

@implementation BuddyListVC

- (XMPPStream *)xmppStream {
    return [[XMPPManager sharedInstance] xmppStream];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialization];

    // Do any additional setup after loading the view.
}

-(void)initialization{
    XMPPManager *manager = [XMPPManager sharedInstance];
    
    manager._chatDelegate = self;
    onlineBuddies = [[NSMutableArray alloc]init];
    

}


-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    NSString * userId = [[UserDefaultsManager sharedInstance]getUserId];
    if (userId) {
        
        if ([[XMPPManager sharedInstance] connect]) {
            
            NSLog(@"show buddy list");
            
        }
        
    } else {
        
        [self navigateToLogin];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnClick:(id)sender {
    [self navigateToLogin];

}

- (IBAction)addButtonClick:(id)sender {
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * addBuddy = [sb instantiateViewControllerWithIdentifier:@"AddBuddyVC"];
    [self presentViewController:addBuddy animated:false completion:nil];
    
}



-(void)navigateToLogin{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * login = [sb instantiateViewControllerWithIdentifier:@"LoginVC"];
    [self presentViewController:login animated:false completion:nil];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // start chat with selected buddy
    NSString *userName = (NSString *) [onlineBuddies objectAtIndex:indexPath.row];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ChatVC * chatVC = [sb instantiateViewControllerWithIdentifier:@"ChatVC"];
    chatVC.chatWithUser = userName;
    [self presentViewController:chatVC animated:false completion:nil];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return onlineBuddies.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *s = (NSString *) [onlineBuddies objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"UserCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
    }
    
    cell.textLabel.text = s;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)newBuddyOnline:(NSString *)buddyName {
    
    if(![onlineBuddies containsObject:buddyName]){
        [onlineBuddies addObject:buddyName];
        [self.buddyTable reloadData];
    }
}

- (void)buddyWentOffline:(NSString *)buddyName {
    [onlineBuddies removeObject:buddyName];
    [self.buddyTable reloadData];
}

-(void)didDisconnect{

}
@end
