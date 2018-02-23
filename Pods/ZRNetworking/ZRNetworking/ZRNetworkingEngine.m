//
//  CMNetworkingEngine.m
//  ContractManage
//
//  Created by Ryan on 15/12/31.
//  Copyright © 2015年 monkey. All rights reserved.
//

#import "ZRNetworkingEngine.h"
#import "ZRHttpTool.h"

@interface ZRNetworkingEngine()
@end

@implementation ZRNetworkingEngine


#pragma mark - 网络请求封装

/**
 * GET请求
 */
+ (void)GETWithPath:(NSString *)url param:(id)param success:(void (^)(NSDictionary* responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = nil;
    if (param) {
        params = [NSDictionary dictionaryWithDictionary:param];
    } else {
        params = [NSDictionary dictionary];
    }
    
    NSMutableDictionary *nParemeters;
    
    if (params.allKeys.count > 0) {
        nParemeters = [NSMutableDictionary dictionaryWithDictionary:params];
    } else {
        nParemeters = [NSMutableDictionary dictionary];
    }
    
    NSMutableDictionary *paramData = [NSMutableDictionary dictionary];
    [paramData addEntriesFromDictionary:nParemeters];// 整体拼接字典
    
   
    
    [[ZRHttpTool shareHttpTool] GET:url params:paramData success:^(id responseObject) {
#if DEBUG
        NSLog(@"GET:%@", url);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
#endif
        
        NSDictionary *dict;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = responseObject;
        }else {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
        success(dict);
        
        NSLog(@"%@", dict);

    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 * POST请求
 */
+ (void)POSTWithPath:(NSString *)url
               param:(id)param success:(void (^)( NSDictionary* responseObject))success failure:(void (^)( NSError *error))failure {
    
    NSDictionary *params = nil;
    if (param) {
        params = [NSDictionary dictionaryWithDictionary:param];
    } else {
        params = [NSDictionary dictionary];
    }
    
    NSMutableDictionary *nParemeters;
    
    if (params.allKeys.count > 0)
    {
        nParemeters = [NSMutableDictionary dictionaryWithDictionary:params];
    } else {
        nParemeters = [NSMutableDictionary dictionary];
    }
    
    
    NSMutableDictionary *paramData = [NSMutableDictionary dictionary];
    [paramData addEntriesFromDictionary:nParemeters];
    
    [[ZRHttpTool shareHttpTool] POST:url params:paramData success:^( id responseObject) {
#if DEBUG
        NSLog(@"POST:%@", url);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
#endif
        
        NSDictionary *dict;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = responseObject;
        }else {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
        success(dict);
        
        NSLog(@"%@", dict);
        
        
    } failure:^( NSError *error) {
        failure(error);
    }];
}


/**
 * PUT请求
 */
+ (void)PUTWithPath:(NSString *)url param:(id)param success:(void (^)(NSDictionary* responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = nil;
    if (param) {
        params = [NSDictionary dictionaryWithDictionary:param];
    } else {
        params = [NSDictionary dictionary];
    }
    
    NSMutableDictionary *nParemeters;
    
    if (params.allKeys.count > 0) {
        nParemeters = [NSMutableDictionary dictionaryWithDictionary:params];
    } else {
        nParemeters = [NSMutableDictionary dictionary];
    }
    
    NSMutableDictionary *paramData = [NSMutableDictionary dictionary];
    [paramData addEntriesFromDictionary:nParemeters];// 整体拼接字典
    
    
    
    [[ZRHttpTool shareHttpTool] PUT:url params:paramData success:^(id responseObject) {
#if DEBUG
        NSLog(@"PUT:%@", url);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
#endif
        
        NSDictionary *dict;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = responseObject;
        }else {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
        success(dict);
        
        NSLog(@"%@", dict);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}


/**
 * PATCH请求
 */
+ (void)PATCHWithPath:(NSString *)url param:(id)param success:(void (^)(NSDictionary* responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = nil;
    if (param) {
        params = [NSDictionary dictionaryWithDictionary:param];
    } else {
        params = [NSDictionary dictionary];
    }
    
    NSMutableDictionary *nParemeters;
    
    if (params.allKeys.count > 0) {
        nParemeters = [NSMutableDictionary dictionaryWithDictionary:params];
    } else {
        nParemeters = [NSMutableDictionary dictionary];
    }
    
    NSMutableDictionary *paramData = [NSMutableDictionary dictionary];
    [paramData addEntriesFromDictionary:nParemeters];// 整体拼接字典
    
    
    
    [[ZRHttpTool shareHttpTool] PATCH:url params:paramData success:^(id responseObject) {
#if DEBUG
        NSLog(@"PATCH:%@", url);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
#endif
        
        NSDictionary *dict;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = responseObject;
        }else {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
        success(dict);
        
        NSLog(@"%@", dict);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

/**
 * DELETE请求
 */
+ (void)DELETEWithPath:(NSString *)url param:(id)param success:(void (^)(NSDictionary* responseObject))success failure:(void (^)(NSError *error))failure {
    
    NSDictionary *params = nil;
    if (param) {
        params = [NSDictionary dictionaryWithDictionary:param];
    } else {
        params = [NSDictionary dictionary];
    }
    
    NSMutableDictionary *nParemeters;
    
    if (params.allKeys.count > 0) {
        nParemeters = [NSMutableDictionary dictionaryWithDictionary:params];
    } else {
        nParemeters = [NSMutableDictionary dictionary];
    }
    
    NSMutableDictionary *paramData = [NSMutableDictionary dictionary];
    [paramData addEntriesFromDictionary:nParemeters];// 整体拼接字典
    
    
    
    [[ZRHttpTool shareHttpTool] DELETE:url params:paramData success:^(id responseObject) {
#if DEBUG
        NSLog(@"DELETE:%@", url);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
#endif
        
        NSDictionary *dict;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = responseObject;
        }else {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        
        success(dict);
        
        NSLog(@"%@", dict);
        
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 上传/下载

/**
 文件下载
 
 @param URLString 文件地址
 @param localPath 本地保存路径
 @param downProgress 下载进度
 @param success 下载成功的回调
 @param failure 下载失败的回调
 */
+ (void)downloadWithURLString:(NSString *)URLString
                localSavePath: (NSString *)localPath
                 downProgress:(void(^)(float progress))downProgress
                      success:(void (^)(NSDictionary* responseObject))success
                      failure:(void (^)(NSError *error))failure {
    [[ZRHttpTool shareHttpTool] downloadWithURLString:URLString localSavePath:localPath downProgress:^(float progress) {
        downProgress(progress);
    } success:^(id response) {
#if DEBUG
        NSLog(@"upload:%@", URLString);
        NSString *string = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
#endif
        NSDictionary *dict;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dict = response;
        }else {
            dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableContainers error:nil];
        }
        success(dict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}


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
- (void)uploadWithURLString:(NSString *)URLString params:(NSDictionary *)params paths: (NSArray *)paths mimeType: (NSString *)mimeType upProgress:(void(^)(float progress))upProgress success:(void (^)(NSDictionary* responseObject))success failure:(void (^)(NSError *error))failure {
    [[ZRHttpTool shareHttpTool] uploadWithURLString:URLString params:params paths:paths mimeType:mimeType upProgress:^(float progress) {
        upProgress(progress);
    } success:^(id responseObject) {
#if DEBUG
        NSLog(@"upload:%@", URLString);
        NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",string);
#endif
        NSDictionary *dict;
        if ([responseObject isKindOfClass:[NSDictionary class]]) {
            dict = responseObject;
        }else {
            dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        }
        success(dict);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end
