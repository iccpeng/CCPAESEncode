//
//  CCPAESTool.h
//  CCPAESEncode
//
//  Created by DR on 16/9/7.
//  Copyright © 2016年 CCP. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  AES 工具类
 */

@interface CCPAESTool : NSObject

/************************************************************************
 函数名称 : + (NSString *)inputDictionary:(NSMutableDictionary *)dict andSecretKey:(NSString *)key;
 函数描述 : 将传进来的字典 进行 AES 加密后转成json字符串
 
 加密的过程: 字典 --> json字符串 --> base64加密后的字符串 --> AES加密后base64再加密 --> 输出加密后的字符串
 
 输入参数 : base64String  base64编码的字符串 ; key  密钥
 返回参数 :  (NSDictionary *)dic  字典
 **********************************************************************
 */
+ (NSString *)inputDictionary:(NSMutableDictionary *)dict andSecretKey:(NSString *)key;

/************************************************************************
 函数名称 : + (NSDictionary *)inputBase64String:(NSString *)base64String andSecretKey:(NSString *)key;
 函数描述 : 将传进来的base64编码的字符 进行 AES 解密后转成字典
 
 解密的过程 : 与加密过程相反
 
 输入参数 : base64String  base64编码的字符串 ; key  密钥
 返回参数 :  (NSDictionary *)dic  字典
 **********************************************************************
 */
+ (NSDictionary *)inputBase64String:(NSString *)base64String andSecretKey:(NSString *)key;

/************************************************************************
 函数名称 : + (NSString*)dictionaryToJson:(NSDictionary *)dic;
 函数描述 : 将字典转换成字符串
 输入参数 : (NSDictionary *)dic  字典
 返回参数 : 字符串
 **********************************************************************
 */
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;

/************************************************************************
 函数名称 : + (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
 函数描述 : 将json字符串转换成字典
 输入参数 : (NSString *)jsonString  Json格式的字符串
 返回参数 : 字典
 **********************************************************************
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
