//
//  ChatVC.m
//  XmppDemoApp
//
//  Created by Rohit palod on 20/04/17.
//  Copyright © 2017 Craterzone. All rights reserved.
//

#import "ChatVC.h"
#import "Constants.h"
#import "XMPPManager.h"
#import "NSString+enhancement.h"
#import <CoreText/CoreText.h>
#import "CustomCell.h"
@interface ChatVC ()
{
    NSMutableArray * messages;
    
}
@end

static NSString * messageCell=@"MessageCell";
static NSString * buddyMessageCell=@"BuddyMessageCell";

@implementation ChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self doInitialization];
 //   [self registerCells];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [self registerNotification];
    // Do any additional setup after loading the view.
}

-(void)doInitialization{
    messages = [[NSMutableArray alloc]init];
    
    XMPPManager  *manager = [XMPPManager sharedInstance];
    manager._messageDelegate = self;
    //Adjusting Height Of Cell As According To Tweet Text
    self.chatTable.estimatedRowHeight = 60;
    self.chatTable.rowHeight = UITableViewAutomaticDimension;
}

-(void)registerCells{
//    [self.chatTable registerNib:[UINib nibWithNibName:@"MyMessageCell" bundle:nil] forCellReuseIdentifier:myMessageCell];
//    [self.chatTable registerNib:[UINib nibWithNibName:@"BuddyMessageCell" bundle:nil] forCellReuseIdentifier:buddyMessageCell];
}


- (XMPPStream *)xmppStream {
    return [[XMPPManager sharedInstance] xmppStream];
   
}



-(void)dismissKeyboard
{
    [_messageField resignFirstResponder];
}

-(void)registerNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self                                                selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancelBtnClick:(id)sender {
    [self dismissViewControllerAnimated:false completion:nil];
}

- (IBAction)sendMessageClick:(UIButton *)sender {
    NSString *messageStr = self.messageField.text;
    
    if([messageStr length] > 0) {
        
        NSXMLElement *body = [NSXMLElement elementWithName:@"body"];
        [body setStringValue:messageStr];
        
        NSXMLElement *message = [NSXMLElement elementWithName:@"message"];
        [message addAttributeWithName:@"type" stringValue:@"chat"];
        [message addAttributeWithName:@"to" stringValue:self.chatWithUser];
        [message addChild:body];
        
        [self.xmppStream sendElement:message];
        
        self.messageField.text = @"";

        // send message through XMPP
        
        self.messageField.text = @"";
        
    //    NSString *msg = [NSString stringWithFormat:@"%@:%@", messageStr, @"you"];
        
        NSMutableDictionary * dict = [[NSMutableDictionary alloc] init];
        [dict setObject:messageStr forKey:MESSAGES];
        [dict setObject:ME forKey:SENDER];
        [dict setObject:[NSString getCurrentTime] forKey:TIME];
        [messages addObject:dict];
        [self.chatTable reloadData];
    }
    [_messageField resignFirstResponder];
}


#pragma mark- tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = (NSDictionary *)[messages objectAtIndex:indexPath.row];
    NSString *message = [dict objectForKey:@"msg"];
    NSUInteger padding = 20;
    CGSize size =  [self heightStringWithEmojis:message fontType:[UIFont boldSystemFontOfSize:13] ForWidth:320 ForMinimumLineSpace:3];
    
    
    
    CGFloat height = size.height < 95 ? 105 : size.height + padding;
    return height;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return messages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSDictionary *dict = (NSDictionary *) [messages objectAtIndex:indexPath.row];
//    
//    UITableViewCell *newCell;
//    
//    if([[dict objectForKey:SENDER] isEqualToString:ME]){
//        MyMessageCell *cell = ( MyMessageCell*)[tableView dequeueReusableCellWithIdentifier:myMessageCell];
//        
//        [cell setCellData:dict];
//        cell.messageField.layer.borderColor = [[UIColor clearColor ]CGColor];
//        cell.nameField.layer.borderColor = [[UIColor clearColor ]CGColor];
//        cell.timeField.layer.borderColor = [[UIColor clearColor ]CGColor];
//        cell.seperaterView.layer.borderColor = [[UIColor clearColor]CGColor];
//        cell.cellView.layer.cornerRadius = 15;
//        newCell =cell;
//    }
//    else{
//        BuddyMessageCell * cell = (BuddyMessageCell *)[tableView dequeueReusableCellWithIdentifier:buddyMessageCell];
//        [cell setCellData:dict];
//        cell.messageField.layer.borderColor = [[UIColor clearColor ]CGColor];
//        cell.nameField.layer.borderColor = [[UIColor clearColor ]CGColor];
//        cell.timeField.layer.borderColor = [[UIColor clearColor ]CGColor];
//        cell.seperaterView.layer.borderColor = [[UIColor clearColor]CGColor];
//        cell.cellView.layer.cornerRadius = 15;
//        newCell = cell;
//    }
//    
//    
//    newCell.userInteractionEnabled = NO;
    
//    return newCell;
    
    NSDictionary *messageDictionary = (NSDictionary *) [messages objectAtIndex:indexPath.row];
    CustomCell *cell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:messageCell];
    
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageCell] ;
    }
    
    NSString *sender = [messageDictionary objectForKey:SENDER];
    NSString *message = [messageDictionary objectForKey:MESSAGES];
    NSString *time = [messageDictionary objectForKey:TIME];
    
    
    CGSize size =  [self heightStringWithEmojis:message fontType:[UIFont boldSystemFontOfSize:13] ForWidth:320 ForMinimumLineSpace:3];
    cell.messageContentView.text = message;
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.userInteractionEnabled = NO;
    
    NSUInteger padding = 20;
    UIImage *bgImage = nil;
    
    
    if ([sender isEqualToString:ME]) { // left aligned
        bgImage = [[UIImage imageNamed:@"SendMsg"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
        
        [cell.messageContentView setFrame:CGRectMake(320 - size.width - padding,
                                                     padding*2,
                                                     size.width + padding ,
                                                     size.height + padding)];
        
        [cell.bgImageView setFrame:CGRectMake(cell.messageContentView.frame.origin.x - padding/2,
                                              cell.messageContentView.frame.origin.y - padding/4,
                                              size.width+padding *1.5,
                                              size.height+(padding * 1.5))];
        
        
    } else {
        
        bgImage = [[UIImage imageNamed:@"RecieveMsg"] stretchableImageWithLeftCapWidth:24  topCapHeight:15];
        
        [cell.messageContentView setFrame:CGRectMake(padding, padding, size.width + padding, size.height+padding)];
        
        [cell.bgImageView setFrame:CGRectMake( cell.messageContentView.frame.origin.x - padding/2,
                                              cell.messageContentView.frame.origin.y - padding/4,
                                              size.width+padding * 1.5,
                                              size.height+(padding * 1.2))];
        
    }
    
    cell.bgImageView.image = bgImage;
    cell.senderAndTimeLabel.text = [NSString stringWithFormat:@"%@", time];
    
    
    return cell;

    
}

- (CGSize)heightStringWithEmojis:(NSString*)str fontType:(UIFont *)uiFont ForWidth:(CGFloat)width ForMinimumLineSpace:(CGFloat)lineSpace{
    
    // Get text
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault, 0);
    CFAttributedStringReplaceString (attrString, CFRangeMake(0, 0), (CFStringRef) str );
    CFIndex stringLength = CFStringGetLength((CFStringRef) attrString);
    
    // Change font
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef) uiFont.fontName, uiFont.pointSize, NULL);
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, stringLength), kCTFontAttributeName, ctFont);
    
    // For Line Space
    const CTParagraphStyleSetting styleSettings[] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpace},
    };
    CTParagraphStyleRef style = CTParagraphStyleCreate((const CTParagraphStyleSetting*)styleSettings, 1);
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, stringLength), kCTParagraphStyleAttributeName, style);
    
    // Calc the size
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    CFRange fitRange;
    CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, stringLength), NULL, CGSizeMake(width, 9999), &fitRange);
    
    CFRelease(ctFont);
    
    CFRelease(style);
    
    CFRelease(framesetter);
    CFRelease(attrString);
    
    return frameSize;
    
}

#pragma mark - keyboard movements
- (void)keyboardWillShow:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = -keyboardSize.height;
        self.view.frame = frame;
    }];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0.0f;
        self.view.frame = frame;
    }];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(void)newMessageReceived:(NSDictionary *)messageContent{
    
    if(messageContent !=nil){
        
        NSMutableDictionary * newDict =[NSMutableDictionary dictionaryWithDictionary:messageContent];
        [newDict setObject:[NSString getCurrentTime] forKey:TIME];
        [messages addObject:newDict];
        [self.chatTable reloadData];
    }
    
}

@end
