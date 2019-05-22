//
//  NSString+Hash.h
//  Main
//
//  Created by LoiTT on 1/10/14.
//  Copyright (c) 2014 FIS Global. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MAHash)

- (NSData *)MD5Data;
- (NSString *)MD5;
- (NSString *)SHA1;
@end
