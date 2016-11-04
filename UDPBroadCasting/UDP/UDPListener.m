//
//  UDPListener.m
//  UDPBroadCasting
//
//  Created by Anindya Das on 11/3/16.
//  Copyright © 2016 AppsInception. All rights reserved.
//

#import "UDPListener.h"

#define UDPPORT "3250"

#define MAXBUFLEN 1024
@implementation UDPListener

+(int)initializeUDPListener{
    
    int sockfd = 0;
    struct addrinfo hints, *servinfo, *p;
    int rv;
    int numbytes;
    struct sockaddr_storage their_addr;
    char buf[MAXBUFLEN];
    socklen_t addr_len;
    char s[INET6_ADDRSTRLEN];
    
    memset(&hints, 0, sizeof hints);
    hints.ai_family = AF_UNSPEC;
    hints.ai_socktype = SOCK_DGRAM;
    hints.ai_flags = AI_PASSIVE;
    
    if ((rv = getaddrinfo(NULL, UDPPORT, &hints, &servinfo)) != 0) {
        fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(rv));
        return 1;
    }
    
    while (1) {
        
        @try {
            for(p = servinfo; p != NULL; p = p->ai_next) {
                if ((sockfd = socket(p->ai_family, p->ai_socktype,
                                     p->ai_protocol)) == -1) {
                    perror("listener: socket");
                    continue;
                }
                
                if (bind(sockfd, p->ai_addr, p->ai_addrlen) == -1) {
                    close(sockfd);
                    perror("listener: bind");
                    continue;
                }
                
                break;
            }
            
            if (p == NULL) {
                fprintf(stderr, "listener: failed to bind socket\n");
                return 2;
            }
            
            addr_len = sizeof their_addr;
            if ((numbytes = recvfrom(sockfd, buf, MAXBUFLEN-1 , 0,
                                     (struct sockaddr *)&their_addr, &addr_len)) == -1) {
                perror("recvfrom");
                exit(1);
            }
          
            buf[numbytes] = '\0';
            NSString *IPAdr=[[NSString stringWithFormat:@"%s" , inet_ntop(their_addr.ss_family,
                                                                         get_in_addr((struct sockaddr *)&their_addr),
                                                                          s, sizeof s)]stringByReplacingOccurrencesOfString:@"::ffff:"
                             withString:@""];
            NSString *Msg=[NSString stringWithFormat:@"%s" , buf];
            
            
            NSMutableArray *data=[NSMutableArray array];
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:@"UDPChat"]!=nil) {
                data=[NSMutableArray arrayWithArray: [[NSUserDefaults standardUserDefaults] objectForKey:@"UDPChat"]];
            }
            
            
            NSMutableDictionary *dic = [[NSMutableDictionary  alloc] init];
            [dic setObject:IPAdr forKey:@"ip"];
            [dic setObject:Msg forKey:@"msg"];
            [data addObject:dic];
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"UDPChat"];
            
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter]
             postNotificationName:@"MessageNotification"
             object:self];
            close(sockfd);
        }
        @finally{
            //  freeaddrinfo(servinfo);
        }
        
    }
    
    return 0;
    
}


void *get_in_addr(struct sockaddr *sa)
{
    if (sa->sa_family == AF_INET) {
        return &(((struct sockaddr_in*)sa)->sin_addr);
    }
    
    return &(((struct sockaddr_in6*)sa)->sin6_addr);
}


@end
