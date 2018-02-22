//
//  CMHttpTool.m
//  ContractManage
//
//  Created by Ryan on 15/12/31.
//  Copyright © 2015年 monkey. All rights reserved.
//

#import "TFHttpTool.h"
#import "AFNetworking.h"

@interface TFHttpTool ()

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
/** <#content#> */
@property (nonatomic, strong) NSMutableArray *tasks;
@end

@implementation TFHttpTool

- (NSMutableArray *)tasks
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tasks = [NSMutableArray array];
    });
    return _tasks;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.httpManager = [AFHTTPSessionManager manager];
        self.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.httpManager.requestSerializer.timeoutInterval = 60.0f;
        self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*"]];
    }
    return self;
}


+ (instancetype)shareHttpTool
{
    static dispatch_once_t onceToken;
    
    static TFHttpTool *instance;
    
    dispatch_once(&onceToken, ^{
        // 调用构造方法
        instance = [[self alloc] init];
        
    });
    return instance;
    
}



/**
 * GET请求
 */
- (void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{
    [self.httpManager GET:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // -999 一般是频繁操作导致的网络错误
        if (failure && error.code != -999) {
            failure(error);
        }
    }];
}


/**
 * POST请求
 */
- (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure
{

    [self.httpManager POST:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // -999 一般是频繁操作导致的网络错误
        if (failure && error.code != -999) {
            failure(error);
        }
    }];
}








@end
