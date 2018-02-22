//
//  CMNetworkingEngine.m
//  ContractManage
//
//  Created by Ryan on 15/12/31.
//  Copyright © 2015年 monkey. All rights reserved.
//

#import "TFNetworkingEngine.h"
#import "TFHttpTool.h"

@interface TFNetworkingEngine()
@end

@implementation TFNetworkingEngine


#pragma mark - 网络请求封装

/**
 * GET请求
 */
+ (void)GETWithPath:(NSString *)url param:(id)param success:(void (^)(NSDictionary* responseObject))success failure:(void (^)(NSError *error))failure
{
    
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
    
    NSLog(@"GET:%@", url);
    
    [[TFHttpTool shareHttpTool] GET:url params:paramData success:^(id responseObject) {
#if DEBUG
        
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
    
    NSLog(@"POST:%@", url);
    
    
    [[TFHttpTool shareHttpTool] POST:url params:paramData success:^( id responseObject) {
#if DEBUG
        
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


#pragma mark - 业务网络请求

@end
