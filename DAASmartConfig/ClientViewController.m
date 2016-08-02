//
//  ClientViewController.m
//  DAASmartConfig
//
//  Created by alezai on 16/8/2.
//  Copyright © 2016年 DAA. All rights reserved.
//

#import "ClientViewController.h"
#import "GCDAsyncUdpSocket.h"

@interface ClientViewController () <GCDAsyncUdpSocketDelegate>

@property (nonatomic, strong) GCDAsyncUdpSocket *socket;

@end

@implementation ClientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
    sendButton.titleLabel.text = @"Hello!";
    sendButton.titleLabel.font = [UIFont systemFontOfSize:30];
    sendButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [sendButton setTitle:@"send" forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(send:) forControlEvents:UIControlEventTouchUpInside];
    sendButton.frame = CGRectMake(0, 0, 100, 50);
    sendButton.center = self.view.center;
    [self.view addSubview:sendButton];
    
    self.socket = [[GCDAsyncUdpSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSError *error = nil;
    [self.socket enableBroadcast:YES error:&error];
    [self.socket bindToPort:9527 error:&error];
}

- (void)send:(UIButton *)button {
    NSString *msg = @"NicoNicoNi";
    NSData *msgData = [msg dataUsingEncoding:NSUTF8StringEncoding];
    [self.socket sendData:msgData toHost:@"255.255.255.255" port:9527 withTimeout:-1 tag:0];
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address {
    NSLog(@"client connect");
}

- (void)udpSocketDidClose:(GCDAsyncUdpSocket *)sock withError:(NSError *)error {
    NSLog(@"client close");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag {
    NSLog(@"didSend");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error {
    NSLog(@"notSend");
}

@end
