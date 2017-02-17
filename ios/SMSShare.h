//
//  SMSShare.h
//  RNShare
//
//  Created by Diseño Uno BBCL on 23-07-16.
//  Copyright © 2016 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTConvert.h>
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>
#import <React/RCTLog.h>
#import <React/RCTUtils.h>

@interface SMSShare : NSObject <RCTBridgeModule>

- (void *) shareSingle:(NSString *)message failureCallback:(RCTResponseErrorBlock)failureCallback successCallback:(RCTResponseSenderBlock)successCallback;

@end
