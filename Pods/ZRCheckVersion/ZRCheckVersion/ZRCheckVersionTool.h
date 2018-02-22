//
//  TFCheckVersionTool.h
//  TFTemplate
//
//  Created by Ryan on 2018/2/7.
//  Copyright © 2018年 Ryan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRCheckVersionTool : NSObject

/**
 检查版本更新并弹框提示更新(默认：判断、更新、弹框、跳转)
 
 @param appId APPStoreID
 */
+ (void)checkAppVersionAlertWithAppId: (NSString *)appId;

/**
 检查版本更新（可以自定义弹框）
 
 @param appId APPID
 @param result 是否更新版本回调
 */
+ (void)checkAppVersionWithAppId: (NSString *)appId result: (void(^)(BOOL))result;

/**
 判断是否需要更新版本
 
 @param currVer 当前项目版本
 @param appStoreVer 当前APPStore中的版本
 @return 是否需要更新
 */
+ (BOOL)isUpdateWithCurrVer: (NSString *)currVer appStoreVer: (NSString *)appStoreVer;

/**
 获取APPStore的版本
 */
+ (void)getAppStoreVersionWithAppId: (NSString *)appID complete: (void(^)(NSString *appStoreVersion))complete err: (void(^)())err;

/**
 打开APPStore中的应用
 
 @param appId appID
 */
+ (void)openAppStoreWithAppId: (NSString *)appId;
@end
