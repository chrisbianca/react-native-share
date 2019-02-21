//
//  EmailShare.m
//  RNShare
//
//  Created by Diseño Uno BBCL on 23-07-16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "EmailShare.h"

@implementation EmailShare
RCT_EXPORT_MODULE();
- (void)shareSingle:(NSString *)subject
            message:(NSString *)message
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback {

    NSLog(@"Try open view");
    
    NSURL *emailURL = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:?subject=%@&body=%@", subject, message]];
    
    if ([[UIApplication sharedApplication] canOpenURL: emailURL]) {
        [[UIApplication sharedApplication] openURL: emailURL];
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
