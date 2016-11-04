//
//  UDPListener.h
//  UDPBroadCasting
//
//  Created by Anindya Das on 11/3/16.
//  Copyright © 2016 AppsInception. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

@interface UDPListener : NSObject
+(int)initializeUDPListener;
@end
