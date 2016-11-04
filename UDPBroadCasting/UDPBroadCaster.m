//
//  UDPBroadCaster.m
//  UDPBroadCasting
//
//  Created by Anindya Das on 11/3/16.
//  Copyright © 2016 AppsInception. All rights reserved.
//

#import "UDPBroadCaster.h"

#define UDPPORT 3250
@implementation UDPBroadCaster

+(int)MessageBroadCast:(NSString*)ip Message:(NSString*)msg{
    int sockfd;
    struct sockaddr_in their_addr;
    struct hostent *he;
    int numbytes;
    int broadcast = 1;
    
    if ((he=gethostbyname([ip UTF8String])) == NULL) {  // get the host info
        perror("Get host by name");
        exit(1);
    }
    
    if ((sockfd = socket(AF_INET, SOCK_DGRAM, 0)) == -1) {
        perror("socket");
        exit(1);
    }
    
    if (setsockopt(sockfd, SOL_SOCKET, SO_BROADCAST, &broadcast,
                   sizeof broadcast) == -1) {
        perror("setsockopt (SO_BROADCAST)");
        exit(1);
    }
    
    their_addr.sin_family = AF_INET;
    their_addr.sin_port = htons(UDPPORT);
    their_addr.sin_addr = *((struct in_addr *)he->h_addr);
    memset(their_addr.sin_zero, '\0', sizeof their_addr.sin_zero);
    
    if ((numbytes=sendto(sockfd, [msg UTF8String], strlen([msg UTF8String]), 0,
                         (struct sockaddr *)&their_addr, sizeof their_addr)) == -1) {
        perror("sendto");
        exit(1);
    }
    
    printf("sent %d bytes to %s\n", numbytes,
           inet_ntoa(their_addr.sin_addr));
    
    close(sockfd);
    
    return 0;
}

@end
