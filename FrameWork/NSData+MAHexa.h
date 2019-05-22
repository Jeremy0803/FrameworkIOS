//
//  NSData+Hexa.h
//  Main
//
//  Created by LoiTT on 1/10/14.
//  Copyright (c) 2014 FIS Global. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (MAHexa)

+ (NSData *)dataFromHexaString:(NSString *)hexaString;
- (NSString *)hexaString;
@end
