//
//  DirectMessage.h
//  UDPBroadCasting
//
//  Created by Anindya Das on 11/4/16.
//  Copyright © 2016 AppsInception. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DirectMessage : UIViewController
@property (nonatomic, retain) NSString* ip;

@property (strong, nonatomic) IBOutlet UITextField *dMTxt;
- (IBAction)DMBtn:(id)sender;

@end
