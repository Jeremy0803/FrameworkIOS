//
//  NSDataTripleDES.h
//  Main
//
//  Created by Luong Trinh Quoc on 3/7/13.
//  Copyright (c) 2013 Fis G ERP. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 @catagory AES256
 @class NSData
 @description Add AES encryption, decryption methods
*/
@interface NSData (MATripleDES)

/**
 @method encryptedWithKey
 @description Encrypt current data (the receiver of this message) with key by AES algorithm.
 @param key: type NSData, use for AES algorithm
 @returns AES encrypted data, type NSData 
 */
- (NSData*)encryptedWithKey:(NSData*)key;

/**
 @method decryptedWithKey
 @description Decrypt current data (the receiver of this message) with key using AES algorithm.
 @param key: type NSData, use for AES algorithm
 @returns AES Decrypted data, type NSData
 */
- (NSData*)decryptedWithKey:(NSData*) key;
@end
