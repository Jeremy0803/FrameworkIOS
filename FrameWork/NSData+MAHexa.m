//
//  NSData+Hexa.m
//  Main
//
//  Created by LoiTT on 1/10/14.
//  Copyright (c) 2014 FIS Global. All rights reserved.
//

#import "NSData+MAHexa.h"

unsigned char maStringToChar (char a, char b) {
    char encoder[3] = {'\0','\0','\0'};
    encoder[0] = a;
    encoder[1] = b;
    return (char) strtol(encoder,NULL,16);
}

@implementation NSData (MAHexa)

+ (NSData *)dataFromHexaString:(NSString *)hexaString {
    const char * bytes = [hexaString cStringUsingEncoding: NSUTF8StringEncoding];
    NSUInteger length = strlen(bytes);
    unsigned char * r = (unsigned char *) malloc(length/2 + 1);
    unsigned char * index = r;
    
    while ((*bytes) && (*(bytes +1))) {
        *index = maStringToChar(*bytes, *(bytes +1));
        index++;
        bytes+=2;
    }
    *index = '\0';
    
    NSData * result = [NSData dataWithBytes:r length:length/2];
    free(r);
    
    return result;
}

- (NSString *)hexaString {
    NSString *hexString = [self description];
    hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"< >"]];
    hexString = [hexString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return hexString;
}
@end
