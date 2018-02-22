//
//  CMHttpTool.h
//  ContractManage
//
//  Created by Ryan on 15/12/31.
//  Copyright © 2015年 monkey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TFHttpTool : NSObject

+ (instancetype)shareHttpTool;

/**
 * GET请求
 */
- (void)GET:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 * POST请求
 */
- (void)POST:(NSString *)url params:(NSDictionary *)params success:(void (^)(id responseObject))success    failure:(void (^)(NSError *error))failure;


@end
