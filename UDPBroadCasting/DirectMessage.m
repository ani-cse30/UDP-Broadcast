//
//  DirectMessage.m
//  UDPBroadCasting
//
//  Created by Anindya Das on 11/4/16.
//  Copyright © 2016 AppsInception. All rights reserved.
//

#import "DirectMessage.h"
#import "UDPBroadCaster.h"

@interface DirectMessage ()

@end

@implementation DirectMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=[NSString stringWithFormat:@"Direct message to %@",_ip];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)DMBtn:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [UDPBroadCaster MessageBroadCast:_ip Message:_dMTxt.text];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _dMTxt.text=@"";
        });
    });

}
@end
