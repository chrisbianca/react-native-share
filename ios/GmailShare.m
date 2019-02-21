//
//  GmailShare.m
//  RNShare
//
//  Created by Diseño Uno BBCL on 23-07-16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "GmailShare.h"

@implementation GmailShare
RCT_EXPORT_MODULE();
- (void)shareSingle:(NSString *)subject
            message:(NSString *)message
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback {

    NSLog(@"Try open view");
    
    NSURL *gmailURL = [NSURL URLWithString:[NSString stringWithFormat:@"googlegmail:///co?subject=%@&body=%@", subject, message]];
    
    if ([[UIApplication sharedApplication] canOpenURL: gmailURL]) {
        [[UIApplication sharedApplication] openURL: gmailURL];
        successCallback(@[]);
    } else {
        // Cannot open GMail
        NSString *stringURL = @"https://itunes.apple.com/gb/app/gmail/id422689480?mt=8";
        NSURL *url = [NSURL URLWithString:stringURL];
        [[UIApplication sharedApplication] openURL:url];

        NSString *errorMessage = @"Not installed";
        NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedString(errorMessage, nil)};
        NSError *error = [NSError errorWithDomain:@"com.rnshare" code:1 userInfo:userInfo];
        
        NSLog(errorMessage);
        failureCallback(error);
    }

}


@end
