//
//  FBMessengerShare.m
//  RNShare
//
//  Created by Diseño Uno BBCL on 23-07-16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "FBMessengerShare.h"

@implementation FBMessengerShare
RCT_EXPORT_MODULE();
- (void)shareSingle:(NSString *)url
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback {

    NSLog(@"Try open view");

    NSURL *fbmURL = [NSURL URLWithString:[NSString stringWithFormat:@"fb-messenger://share/?link=%@", url]];

    if ([[UIApplication sharedApplication] canOpenURL: fbmURL]) {
        [[UIApplication sharedApplication] openURL: fbmURL];
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
