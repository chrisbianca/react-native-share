//
//  SMSShare.m
//  RNShare
//
//  Created by Diseño Uno BBCL on 23-07-16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "SMSShare.h"

@implementation SMSShare
RCT_EXPORT_MODULE();
- (void)shareSingle:(NSString *)message
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback {

    NSLog(@"Try open view");

    NSURL *smsURL = [NSURL URLWithString:[NSString stringWithFormat:@"sms:&body=%@", message]];

    if ([[UIApplication sharedApplication] canOpenURL: smsURL]) {
        [[UIApplication sharedApplication] openURL: smsURL];
        successCallback(@[]);
    } else {
        NSString *errorMessage = @"Not installed";
        NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
        NSError *error = [NSError errorWithDomain:@"com.rnshare" code:1 userInfo:userInfo];

        NSLog(errorMessage);
        failureCallback(error);
    }
}


@end
