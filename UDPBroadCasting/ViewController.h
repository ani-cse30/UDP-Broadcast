//
//  ViewController.h
//  UDPBroadCasting
//
//  Created by Anindya Das on 11/3/16.
//  Copyright © 2016 AppsInception. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *msgTxt;
- (IBAction)msgSendBtn:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblView;

@end

