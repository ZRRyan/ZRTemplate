//
//  CMHttpTool.m
//  ContractManage
//
//  Created by Ryan on 15/12/31.
//  Copyright © 2015年 monkey. All rights reserved.
//

#import "ZRHttpTool.h"
#import "AFNetworking.h"

@interface ZRHttpTool ()

@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
@end

@implementation ZRHttpTool

- (instancetype)init {
    if (self = [super init]) {
        self.httpManager = [AFHTTPSessionManager manager];
        self.httpManager.requestSerializer = [AFJSONRequestSerializer serializer];
        self.httpManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.httpManager.requestSerializer.timeoutInterval = 20.0f;
        self.httpManager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*"]];
    }
    return self;
}


+ (instancetype)shareHttpTool {
    static dispatch_once_t onceToken;
    
    static ZRHttpTool *instance;
    
    dispatch_once(&onceToken, ^{
        // 调用构造方法
        instance = [[self alloc] init];
        
    });
    return instance;
    
}



/**
 * GET请求
 */
- (void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self.httpManager GET:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
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
- (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self.httpManager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 * PUT请求
 */
- (void)PUT:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self.httpManager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 * PATCH请求
 */
- (void)PATCH:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self.httpManager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
 * DELETE请求
 */
- (void)DELETE:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self.httpManager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
                      failure:(void (^)(NSError *error))failure {
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURL *url = [NSURL URLWithString:URLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        downProgress(downloadProgress.completedUnitCount * 1.0 / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:localPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            failure(error);
        } else {
            success(response);
        }
    }];
    [downloadTask resume];
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
- (void)uploadWithURLString:(NSString *)URLString params:(NSDictionary *)params paths: (NSArray *)paths mimeType: (NSString *)mimeType upProgress:(void(^)(float progress))upProgress success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure {
    [self.httpManager POST:URLString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSString *path in paths) {
            NSURL *url = [NSURL URLWithString:path];
            NSError *error = nil;
            [formData appendPartWithFileURL:url name:@"file" fileName:@"fileName" mimeType:mimeType error: &error];
            if (error != nil) {
                failure(error);
                return ;
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        upProgress(uploadProgress.completedUnitCount * 1.0 / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}




@end
