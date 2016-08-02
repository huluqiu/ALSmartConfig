//
//  ServerViewController.m
//  DAASmartConfig
//
//  Created by alezai on 16/8/2.
//  Copyright © 2016年 DAA. All rights reserved.
//

#import "ServerViewController.h"
#import "GCDAsyncUdpSocket.h"

@interface ServerViewController () <GCDAsyncUdpSocketDelegate>

@property (nonatomic, strong) GCDAsyncUdpSocket *socket;

@end

@implementation ServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    [self.socket bindToPort:9527 error:&error];
    [self.socket beginReceiving:&error];
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address {
    NSLog(@"server connetct");
}

- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error {
    NSLog(@"server close");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data fromAddress:(NSData *)address withFilterContext:(id)filterContext {
    NSLog(@"did receive");
    if (data) {
        NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@", msg);
    }
}

@end
