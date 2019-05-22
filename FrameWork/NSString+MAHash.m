//
//  NSString+Hash.m
//  Main
//
//  Created by LoiTT on 1/10/14.
//  Copyright (c) 2014 FIS Global. All rights reserved.
//

#import "NSString+MAHash.h"
#import "NSData+MABase64.h"
#import <CommonCrypto/CommonKeyDerivation.h>

@implementation NSString (MAHash)

- (NSData *)MD5Data {
    // Create pointer to the string as UTF16le
    NSData *encode = [self dataUsingEncoding:NSUTF16LittleEndianStringEncoding allowLossyConversion:NO];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(encode.bytes,(CC_LONG)encode.length, digest);
    NSData *hashData = [[NSData alloc] initWithBytes:digest length: sizeof digest];

    return hashData;
}

- (NSString *)MD5 {
    // Create pointer to the string as UTF8
    NSData *encode = [self dataUsingEncoding:NSUTF16LittleEndianStringEncoding];
    const char *ptr = [encode bytes];
    
    // Create byte array of unsigned chars
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

- (NSString *)SHA1 {
    // Create pointer to the string as UTF8
    const char *ptr = [self UTF8String];
    
    // Create byte array of unsigned chars
    unsigned char sha1Buffer[CC_SHA1_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_SHA1(ptr, (CC_LONG)strlen(ptr), sha1Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",sha1Buffer[i]];
    
    return output;
}
@end
