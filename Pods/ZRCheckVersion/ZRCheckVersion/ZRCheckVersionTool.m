
//
//  TFCheckVersionTool.m
//  TFTemplate
//
//  Created by Ryan on 2018/2/7.
//  Copyright © 2018年 Ryan. All rights reserved.
//

#import "ZRCheckVersionTool.h"
#import <UIKit/UIKit.h>

@interface ZRCheckVersionTool()

@end

@implementation ZRCheckVersionTool



/**
 检查版本更新并弹框提示更新

 @param appId APPStoreID
 */
+ (void)checkAppVersionAlertWithAppId: (NSString *)appId {
    [self checkAppVersionWithAppId:appId result:^(BOOL isUpdate) {
        if (isUpdate) {
            [self showUpdateAlertWithAppID:appId];
        }
    }];
}


/**
 检查版本更新

 @param appId APPID
 @param result 是否更新版本回调
 */
+ (void)checkAppVersionWithAppId: (NSString *)appId result: (void(^)(BOOL isUpdate))result {
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *currVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    
    [self getAppStoreVersionWithAppId:appId complete:^(NSString *appStoreVersion) {
        
        if ([self isUpdateWithCurrVer:currVersion appStoreVer:appStoreVersion]) {
            if (result != nil) {
                result(YES);
            }
        } else {
            if (result != nil) {
                result(NO);
            }
        }
    } err:^{
        NSLog(@"获取APPStore版本错误");
    }];
}


/**
 判断是否需要更新版本

 @param currVer 当前项目版本
 @param appStoreVer 当前APPStore中的版本
 @return 是否需要更新
 */
+ (BOOL)isUpdateWithCurrVer: (NSString *)currVer appStoreVer: (NSString *)appStoreVer {

    NSArray *arrCurrVer = [currVer componentsSeparatedByString:@"."];
    NSArray *arrAppStoreVer = [appStoreVer componentsSeparatedByString:@"."];
    
    NSInteger index = 0;
    NSInteger count = arrCurrVer.count <= arrAppStoreVer.count ? arrCurrVer.count : arrAppStoreVer.count;
    NSInteger maxCount = arrCurrVer.count > arrAppStoreVer.count ? arrCurrVer.count : arrAppStoreVer.count;
    while (index < count) {
        NSInteger currV = [arrCurrVer[index] integerValue];
        NSInteger appstoreV = [arrCurrVer[index] integerValue];
        if (currV < appstoreV) {
            return YES;
            break;
        } else if (currV > appstoreV) { // 表示当前版本大于APPStore版本，该版本为审核版本
            break;
        }
        
        index ++;
        
        if (count != maxCount && index == count) { // 特殊处理版本长度不一样的情况
            return YES;
            break;
        }
    }
    return NO;
}

/**
 获取APPStore的版本
 */
+ (void)getAppStoreVersionWithAppId: (NSString *)appID complete: (void(^)(NSString *appStoreVersion))complete err: (void(^)())err {
    
    if (appID == nil || [appID isEqualToString:@""]) {
        NSLog(@"appID 不能为空");
        return;
    }
    
    
    NSString *urlStr = [NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@", appID];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod:@"POST"];
    
    
    NSOperationQueue *queue = [NSOperationQueue new];
    
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,NSData *data,NSError *error){
        if (data) {
            NSDictionary *receiveDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            if ([[receiveDic valueForKey:@"resultCount"] intValue]>0) {
                NSArray *infoArray = receiveDic[@"results"];
                NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
                NSString *appStoreVersion = [releaseInfo objectForKey:@"version"];
                complete(appStoreVersion);
            } else {
                err();
            }
        } else {
            err();
        }
    }];
}

/**
 提示更新
 */
+ (void)showUpdateAlertWithAppID: (NSString *)appId {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"更新" message:@"有新的版本更新，是否前往更新？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *nextAction = [UIAlertAction actionWithTitle:@"下次再说" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *updateAction = [UIAlertAction actionWithTitle:@"前往更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openAppStoreWithAppId:appId];
        
    }];
    
    [alertController addAction:nextAction];
    [alertController addAction:updateAction];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}


/**
 打开APPStore

 @param appId appID
 */
+ (void)openAppStoreWithAppId: (NSString *)appId {
    NSString *str = [NSString stringWithFormat:@"http://itunes.apple.com/us/app?id=%@", appId];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@[] completionHandler:^(BOOL success) {
        
    }];
}

@end
