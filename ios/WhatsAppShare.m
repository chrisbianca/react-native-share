//
//  FacebookShare.m
//  RNShare
//
//  Created by Diseño Uno BBCL on 23-07-16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import "WhatsAppShare.h"

@implementation WhatsAppShare
RCT_EXPORT_MODULE();
- (void)shareSingle:(NSString *)message
    failureCallback:(RCTResponseErrorBlock)failureCallback
    successCallback:(RCTResponseSenderBlock)successCallback {

    NSLog(@"Try open view");
    
    NSURL *whatsappURL = [NSURL URLWithString:[NSString stringWithFormat:@"whatsapp://send?text=%@", message]];

    if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
        [[UIApplication sharedApplication] openURL: whatsappURL];
        successCallback(@[]);
    } else {
      // Cannot open whatsapp
      NSString *stringURL = @"http://itunes.apple.com/en/app/whatsapp-messenger/id310633997";
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
