//
//  ViewController.m
//  UDPBroadCasting
//
//  Created by Anindya Das on 11/3/16.
//  Copyright © 2016 AppsInception. All rights reserved.
//

#import "ViewController.h"
#import "UDPBroadCaster.h"

@interface ViewController ()

@end
NSMutableArray *chat;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"UDP Broadcasting Chatroom";

   chat=[[NSUserDefaults standardUserDefaults] objectForKey:@"UDPChat"];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:)
                                                 name:@"MessageNotification"
                                               object:nil];
    
    }

- (void) receiveTestNotification:(NSNotification *) notification
{
   
    
    if ([[notification name] isEqualToString:@"MessageNotification"])
    {
        chat=[NSMutableArray arrayWithArray: [[NSUserDefaults standardUserDefaults] objectForKey:@"UDPChat"]];
        NSLog(@"ALL MESSAGES:%@",chat);
         NSLog (@"Successfully received the test notification!");
        [_tblView reloadData];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [chat count];    //count number of row from counting array hear cataGorry is An Array
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                       reuseIdentifier:MyIdentifier] ;
    }
    
   
    cell.textLabel.text = [[chat objectAtIndex:indexPath.row] objectForKey:@"ip"];
    cell.detailTextLabel.text=[[chat objectAtIndex:indexPath.row] objectForKey:@"msg"];
    return cell;
}


- (IBAction)msgSendBtn:(id)sender {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UDPBroadCaster MessageBroadCast:@"255.255.255.255" Message:_msgTxt.text];

        dispatch_async(dispatch_get_main_queue(), ^{
            _msgTxt.text=@"";
            [_tblView reloadData];
        });
    });
    
}
@end
