#import "SmssdkPlugin.h"
#import <SMS_SDK/SMSSDK.h>

@implementation SmssdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"smssdk"
                                     binaryMessenger:[registrar messenger]];
    SmssdkPlugin* instance = [[SmssdkPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"init" isEqualToString:call.method]) {
        result(@"");
    } else if ([@"getCode" isEqualToString:call.method]) {
        NSDictionary* argsMap = call.arguments;
        NSString *phone = argsMap[@"phone"];
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phone zone:@"86" template:@"" result:^(NSError *error) {
            if (!error) {
                NSDictionary *dic = @{@"status":@0,@"msg":@"success",};
                result(dic);
            } else {
                NSDictionary *dic = @{@"status":@1,@"msg":error.userInfo[@"description"],};
                result(dic);
            }
        }];
    } else if ([@"commitCode" isEqualToString:call.method]) {
        NSDictionary* argsMap = call.arguments;
        NSString *phone = argsMap[@"phone"];
        NSString *code = argsMap[@"code"];
        [SMSSDK commitVerificationCode:code phoneNumber:phone zone:@"86" result:^(NSError *error) {
            if (!error) {
                NSDictionary *dic = @{@"status":@0,@"msg":@"success",};
                result(dic);
            } else {
                NSDictionary *dic = @{@"status":@1,@"msg":error.userInfo[@"description"],};
                result(dic);
            }
        }];
    }
}

@end
