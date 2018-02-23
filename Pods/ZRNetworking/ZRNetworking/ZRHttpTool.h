//
//  CMHttpTool.h
//  ContractManage
//
//  Created by Ryan on 15/12/31.
//  Copyright © 2015年 monkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRHttpTool : NSObject

+ (instancetype)shareHttpTool;

/**
 * GET请求
 */
- (void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 * POST请求
 */
- (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success    failure:(void (^)(NSError *error))failure;

/**
 * PUT请求
 */
- (void)PUT:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 * PATCH请求
 */
- (void)PATCH:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 * DELETE请求
 */
- (void)DELETE:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;


#pragma mark - 下载

/**
 文件下载
 
 @param URLString 文件地址
 @param localPath 本地保存路径
 @param downProgress 下载进度
 @param success 下载成功的回调
 @param failure 下载失败的回调
 */
- (void)downloadWithURLString:(NSString *)URLString
                localSavePath: (NSString *)localPath
                 downProgress:(void(^)(float progress))downProgress
                      success:(void (^)(id response))success
                      failure:(void (^)(NSError *error))failure;

/**
 文件上传
 
 @param URLString URL路径
 @param params 参数
 @param paths 文件本地路径
 @param mimeType mimeType
 @param upProgress 上传进度
 @param success 成功回调
 @param failure 失败回调
 */
- (void)uploadWithURLString:(NSString *)URLString params:(NSDictionary *)params paths: (NSArray *)paths mimeType: (NSString *)mimeType upProgress:(void(^)(float progress))upProgress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
