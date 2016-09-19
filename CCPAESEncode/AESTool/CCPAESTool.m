//
//  CCPAESTool.m
//  CCPAESEncode
//
//  Created by CCP on 16/9/7.
//  Copyright © 2016年 CCP. All rights reserved.
//

#import "CCPAESTool.h"
#import "GTMBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>

@implementation CCPAESTool

+ (NSString *)inputDictionary:(NSMutableDictionary *)dict andSecretKey:(NSString *)key{
    
    NSString *jsonString = [CCPAESTool dictionaryToJson:dict];
    
    NSString *jsonBase64Str = [GTMBase64 encodeBase64String:jsonString];
    
    NSString *encryptStr = [CCPAESTool AES128Encrypt:jsonBase64Str andSecretKey:key];
    
    return encryptStr;
}

+ (NSDictionary *)inputBase64String:(NSString *)base64String andSecretKey:(NSString *)key {
    
    NSString * jsonString = [CCPAESTool AES128Decrypt:base64String andSecretKey:key];
    
    NSDictionary *dict = [CCPAESTool dictionaryWithJsonString:jsonString];
    
    return dict;
    
}

/**
 *  AES 加密 解密
 */

+(NSString *)AES128Encrypt:(NSString *)plainText andSecretKey:(NSString *)secretKeys
{
    char keyPtr[kCCKeySizeAES128+1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [secretKeys getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = [data length];
    
    NSUInteger diff = kCCKeySizeAES128 - (dataLength % kCCKeySizeAES128);
    NSUInteger newSize = 0;
    
    if(diff > 0)
    {
        newSize = dataLength + diff;
    }
    
    char dataPtr[newSize];
    memcpy(dataPtr, [data bytes], [data length]);
    for(int i = 0; i < diff; i++)
    {
        dataPtr[i + dataLength] = 0x0000; // 注意 No padding
    }
    
    size_t bufferSize = newSize + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    memset(buffer, 0, bufferSize);
    
    size_t numBytesCrypted = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode,
                                          keyPtr,
                                          kCCKeySizeAES128,
                                          NULL,//这个参数iv是个固定值，通常直接使用密钥即可。大家一定要注视这个参数，如果安卓、服务端和iOS端不统一，那么加密结果就会不一样，解密可能能解出来，但是解密后在末尾会出现一些\0、\t之类的。（注: 这里使用NULL）
                                          dataPtr,
                                          sizeof(dataPtr),
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        return [GTMBase64 encodeBase64Data:resultData];
    }
    free(buffer);
    return nil;
}


+ (NSString *)AES128Decrypt:(NSString *)encryptText andSecretKey:(NSString *)secretKeys
{
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [secretKeys getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *data = [GTMBase64 decodeData:[encryptText dataUsingEncoding:NSUTF8StringEncoding]];
    NSUInteger dataLength = [data length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    size_t numBytesCrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          NULL,//这个参数iv是个固定值，通常直接使用密钥即可。大家一定要注视这个参数，如果安卓、服务端和iOS端不统一，那么加密结果就会不一样，解密可能能解出来，但是解密后在末尾会出现一些\0、\t之类的。(注:这里使用NULL)
                                          [data bytes],
                                          dataLength,
                                          buffer,
                                          bufferSize,
                                          &numBytesCrypted);
    if (cryptStatus == kCCSuccess) {
        NSData *resultData = [NSData dataWithBytesNoCopy:buffer length:numBytesCrypted];
        
        return [GTMBase64 decodeBase64Data:resultData];
    }
    free(buffer);
    return nil;
}


+ (NSString*)dictionaryToJson:(NSMutableDictionary *)dic {
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
    
}

@end
