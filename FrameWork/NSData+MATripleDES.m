//
//  NSDataTripleDES.m
//  Main
//
//  Created by Luong Trinh quoc on 3/7/13.
//  Copyright (c) 2013 Fis G ERP. All rights reserved.
//

#import "NSData+MATripleDES.h"
#import <CommonCrypto/CommonCryptor.h>
#import "NSString+MAHash.h"

const size_t MA_KEY_SIZE = kCCKeySize3DES;
@implementation NSData (MATripleDES)

/**
 @method makeCryptedVersionWithKeyData: ofLength: decrypt:
 @description Encrypt/Decrypt current data (the receiver of this message) with key by AES algorithm.
 @param keyData: use for encrypt/ decrypt data by AES algorithm
 @param keyLength: length of key.
 @param decrypt: flag to determine encryption or decryption.
 @returns AES encrypted/decrypted data, type NSData
*/
- (NSData *)makeCryptedVersionWithKeyData:(const void *)keyData ofLength:(int)keyLength decrypt:(bool)decrypt {
    
    // Copy key data, and padding if need
    char key[MA_KEY_SIZE + 1];
    bzero(key, sizeof(key));
    memcpy(key, keyData, keyLength > MA_KEY_SIZE ? MA_KEY_SIZE : keyLength);
    if (keyLength < MA_KEY_SIZE) {
        int paddingBytes = MA_KEY_SIZE - keyLength;
        for (int i = 0; i < paddingBytes; i++) {
            key[keyLength + i] = key[i];
        }
    }
    key[MA_KEY_SIZE] = '\0';
    
    uint8_t iv[MA_KEY_SIZE];
    memset((void *) iv, 0x00, (size_t) sizeof(iv));
    
    // Alloc buffer to save encrypted/decrypted data.
    size_t bufferSize = [self length] + kCCBlockSizeAES128;
    void* buffer = malloc(bufferSize);
    
    size_t dataUsed;
    CCStatus status = CCCrypt(decrypt ? kCCDecrypt : kCCEncrypt,
                              kCCAlgorithm3DES,
                              kCCOptionPKCS7Padding | kCCOptionECBMode,
                              key,
                              MA_KEY_SIZE,
                              iv,
                              [self bytes],
                              [self length],
                              (void *)buffer,
                              bufferSize,
                              &dataUsed);
    
    
    // Check crypto status.
    NSData *data = nil;
	switch(status)
	{
		case kCCSuccess:
			data = [NSData dataWithBytes:buffer length:dataUsed];
            break;
		case kCCParamError:
			NSLog(@"Error: NSDataTripleDES: Could not %s data: Param error", decrypt ? "decrypt" : "encrypt");
			break;
		case kCCBufferTooSmall:
			NSLog(@"Error: NSDataTripleDES: Could not %s data: Buffer too small", decrypt ? "decrypt" : "encrypt");
			break;
		case kCCMemoryFailure:
			NSLog(@"Error: NSDataTripleDES: Could not %s data: Memory failure", decrypt ? "decrypt" : "encrypt");
			break;
		case kCCAlignmentError:
			NSLog(@"Error: NSDataTripleDES: Could not %s data: Alignment error", decrypt ? "decrypt" : "encrypt");
			break;
		case kCCDecodeError:
			NSLog(@"Error: NSDataTripleDES: Could not %s data: Decode error", decrypt ? "decrypt" : "encrypt");
			break;
		case kCCUnimplemented:
			NSLog(@"Error: NSDataTripleDES: Could not %s data: Unimplemented", decrypt ? "decrypt" : "encrypt");
			break;
		default:
			NSLog(@"Error: NSDataTripleDES: Could not %s data: Unknown error", decrypt ? "decrypt" : "encrypt");
	}
    
	free(buffer);
	return data;
}

- (NSData *)encryptedWithKey:(NSData *)key {
    return [self makeCryptedVersionWithKeyData:[key bytes] ofLength:(int)[key length] decrypt:NO];
}

- (NSData *)decryptedWithKey:(NSData *)key {
	return [self makeCryptedVersionWithKeyData:[key bytes] ofLength:(int)[key length] decrypt:YES];
}

@end
