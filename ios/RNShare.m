#import "RNShare.h"

#import <React/RCTConvert.h>
#import <React/RCTLog.h>
#import <React/RCTUtils.h>
#import <React/RCTBridge.h>
#import <React/RCTUIManager.h>

#import "EmailShare.h"
#import "GenericShare.h"
#import "GmailShare.h"
#import "GooglePlusShare.h"
#import "SMSShare.h"
#import "WhatsAppShare.h"

@implementation RNShare
- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}
RCT_EXPORT_MODULE()

RCT_EXPORT_METHOD(shareSingle:(NSDictionary *)options
                  failureCallback:(RCTResponseErrorBlock)failureCallback
                  successCallback:(RCTResponseSenderBlock)successCallback)
{
    NSString *subject = [[RCTConvert NSString:options[@"subject"]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *text = [[[RCTConvert NSString:options[@"message"]] stringByAppendingString:@" "] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *url = [[[RCTConvert NSString:options[@"url"]] stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"] stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    
    NSString *message;
    if (url == nil) {
        message = text;
    } else if ([text containsString:@"--url--"]) {
        message = [text stringByReplacingOccurrencesOfString:@"--url--" withString:url];
    } else {
        message = [text stringByAppendingString:url];
    }
    
    NSString *social = [RCTConvert NSString:options[@"social"]];
    
    if (social) {
        NSLog(social);
        if([social isEqualToString:@"facebook"]) {
            NSLog(@"TRY OPEN FACEBOOK");
            GenericShare *shareCtl = [[GenericShare alloc] init];
            [shareCtl shareSingle:options failureCallback:failureCallback successCallback:successCallback serviceType: SLServiceTypeFacebook];
        } else if([social isEqualToString:@"twitter"]) {
            NSLog(@"TRY OPEN Twitter");
            GenericShare *shareCtl = [[GenericShare alloc] init];
            [shareCtl shareSingle:options failureCallback:failureCallback successCallback:successCallback serviceType: SLServiceTypeTwitter];
        } else if([social isEqualToString:@"googleplus"]) {
            NSLog(@"TRY OPEN google plus");
            GooglePlusShare *shareCtl = [[GooglePlusShare alloc] init];
            [shareCtl shareSingle:options failureCallback:failureCallback successCallback:successCallback];
        } else if([social isEqualToString:@"whatsapp"]) {
            NSLog(@"TRY OPEN whatsapp");
            WhatsAppShare *shareCtl = [[WhatsAppShare alloc] init];
            [shareCtl shareSingle:message failureCallback:failureCallback successCallback:successCallback];
        } else if([social isEqualToString:@"email"]) {
            NSLog(@"TRY OPEN email");
            EmailShare *shareCtl = [[EmailShare alloc] init];
            [shareCtl shareSingle:subject message:message failureCallback:failureCallback successCallback:successCallback];
        } else if ([social isEqualToString:@"gmail"]) {
            NSLog(@"TRY OPEN gmail");
            GmailShare *shareCtl = [[GmailShare alloc] init];
            [shareCtl shareSingle:subject message:message failureCallback:failureCallback successCallback:successCallback];
        } else if ([social isEqualToString:@"sms"]) {
            NSLog(@"TRY OPEN sms");
            SMSShare *shareCtl = [[SMSShare alloc] init];
            [shareCtl shareSingle:message failureCallback:failureCallback successCallback:successCallback];
        }
    } else {
        RCTLogError(@"No exists social key");
        return;
    }
}

@end
