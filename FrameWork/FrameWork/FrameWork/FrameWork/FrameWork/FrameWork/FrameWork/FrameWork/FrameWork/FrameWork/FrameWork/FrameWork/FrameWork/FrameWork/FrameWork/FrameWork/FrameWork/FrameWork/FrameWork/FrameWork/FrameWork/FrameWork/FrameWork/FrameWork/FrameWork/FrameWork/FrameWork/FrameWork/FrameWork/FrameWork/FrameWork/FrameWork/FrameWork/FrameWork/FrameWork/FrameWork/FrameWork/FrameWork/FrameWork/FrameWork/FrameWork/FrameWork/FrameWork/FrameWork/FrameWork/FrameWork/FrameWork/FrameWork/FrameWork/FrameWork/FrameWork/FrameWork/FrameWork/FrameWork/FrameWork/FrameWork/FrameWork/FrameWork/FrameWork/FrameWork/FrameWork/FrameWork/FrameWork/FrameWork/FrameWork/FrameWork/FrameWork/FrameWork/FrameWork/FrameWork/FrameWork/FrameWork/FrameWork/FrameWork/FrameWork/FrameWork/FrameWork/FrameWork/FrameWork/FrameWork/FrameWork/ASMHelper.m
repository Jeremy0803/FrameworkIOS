//
//  ASMHelper.m
//  mASM
//
//  Created by LoiTT on 12/14/14.
//  Copyright (c) 2014 FPT. All rights reserved.
//

#import "ASMHelper.h"
#import "NSData+MATripleDES.h"
#import "NSData+MABase64.h"
#import "NSData+MAHexa.h"
#import "NSString+MAHash.h"

NSString *const SECRET_KEY = @"!@#$%^&*()~_+|";

@implementation ASMHelper
/**
 Created by LoiTT on 12/14/14.
 */
+ (NSString *)localizedStringWithKey:(NSString *)key {
    NSString *localizeString = nil;
    
    // Lay gia tri chuoi localize voi key truyen vao.
    localizeString = NSLocalizedString(key, nil);
    
    return localizeString;
}

/**
 Created by LoiTT on 12/14/14.
 */
static NSNumberFormatter *numberFormatter;
+ (NSString *)convertAmountToString:(NSNumber *)amount{
//    if (amount == nil) {
//        amount = [NSNumber numberWithDouble:0];
//    }
//    
//    // Chuyen doi tuong NSNumber thanh chuoi (NSString).
//    NSString *strSign = @"";
//    NSString *strPrice = @"";
//    NSString *temp = [NSString stringWithFormat:@"%.2f", [amount doubleValue]];
//    if (amount.longLongValue < 0) {
//        strSign = [temp substringToIndex:1];
//        temp = [temp substringFromIndex:1];
//    }
//    
//    // Cat phan thap phan
//    if ([temp rangeOfString:@"."].location != NSNotFound) {
//        strPrice = [temp substringFromIndex:[temp rangeOfString:@"."].location];
//        temp = [temp substringToIndex:[temp rangeOfString:@"."].location];
//    }
//    
//    // Noi them 0 neu temp = rong.
//    if (temp.length == 0) {
//        strPrice = [NSString stringWithFormat:@"0%@", strPrice];
//    }
//    
//    // Cat chuoi theo khoi 3 ky tu va noi voi nhau bang dau ","
//    while (temp.length > 3) {
//        NSString *str = [temp substringFromIndex:temp.length - 3];
//        temp = [temp substringToIndex:temp.length - 3];
//        if (strPrice.length == 0) {
//            strPrice = [NSString stringWithString:str];
//        }
//        else if ([strPrice hasPrefix:@"."]) {
//            strPrice = [NSString stringWithFormat:@"%@%@", str, strPrice];
//        }
//        else {
//            strPrice = [NSString stringWithFormat:@"%@,%@", str, strPrice];
//        }
//    }
//    
//    
//    // Noi them chuoi con lai trong truong hop chieu dai chuoi con lai > 0.
//    if (temp.length > 0) {
//        if ([strPrice hasPrefix:@"."]) {
//            strPrice = [NSString stringWithFormat:@"%@%@", temp, strPrice];
//        }
//        else {
//            strPrice = [NSString stringWithFormat:@"%@,%@", temp, strPrice];
//        }
//    }
//    
//    // Noi lai dau.
//    strPrice = [NSString stringWithFormat:@"%@%@", strSign, strPrice];
    
    if (!numberFormatter) {
        NSString *groupingSeparator = [[NSLocale currentLocale] objectForKey:NSLocaleGroupingSeparator];
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setGroupingSeparator:groupingSeparator];
        [numberFormatter setGroupingSize:3];
        [numberFormatter setAlwaysShowsDecimalSeparator:NO];
        [numberFormatter setUsesGroupingSeparator:YES];
        [numberFormatter setMaximumFractionDigits:0];
    }
    NSString *strPrice = [numberFormatter stringFromNumber:amount];
    return strPrice;
}

/**
 Created by LoiTT on 12/14/14.
 */
+ (NSString *)formatAmountString:(NSString *)string {
    // Copy lai chuoi (NSString).
    NSString *strPrice = @"";
    NSString *temp = [NSString stringWithFormat:@"%@", string];
    
    // Cat chuoi theo khoi 3 ky tu va noi voi nhau bang dau "."
    while (temp.length > 3) {
        NSString *str = [temp substringFromIndex:temp.length - 3];
        temp = [temp substringToIndex:temp.length - 3];
        if (strPrice.length == 0) {
            strPrice = [NSString stringWithString:str];
        }
        else
            strPrice = [NSString stringWithFormat:@"%@,%@", str, strPrice];
    }
    
    // Noi them chuoi con lai trong truong hop chieu dai chuoi con lai > 0.
    if ([strPrice isEqualToString:@""]) {
        return temp;
    }
    else {
       return [NSString stringWithFormat:@"%@,%@", temp, strPrice];
    }
}

/**
 Created by LoiTT on 12/14/14.
 */
static NSDateFormatter *dateFormat;
+ (NSString *)convertDateToString:(NSDate *)date {
    if (dateFormat == nil) {
        dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.locale = [NSLocale systemLocale];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
    }
    
    NSString *strDate = @"";
    if (date) {
        strDate = [dateFormat stringFromDate:date];
    }
    return strDate;
}

/**
 Created by LoiTT on 12/14/14.
 */
+ (NSDate *)convertStringToDate:(NSString *)strDate {
    if (dateFormat == nil) {
        dateFormat = [[NSDateFormatter alloc] init];
        dateFormat.locale = [NSLocale systemLocale];
        [dateFormat setDateFormat:@"dd/MM/yyyy"];
    }
    
    NSDate *date = nil;
    if (strDate) {
        date = [dateFormat dateFromString:strDate];
    }
    return date;
}

/**
 Created by LoiTT on 12/14/14.
 */
+ (NSDate *)convertStringToDateTime:(NSString *)strDateTime {
    if (dateTimeFormat == nil) {
        NSString *strDateTimeFormat = @"dd/MM/yyyy HH:mm:ss";
        dateTimeFormat = [[NSDateFormatter alloc] init];
        dateTimeFormat.locale = [NSLocale systemLocale];
        [dateTimeFormat setDateFormat:strDateTimeFormat];
    }
    
    NSDate *date = nil;
    if (strDateTime) {
        date = [dateTimeFormat dateFromString:strDateTime];
    }
    return date;
}

/**
 Created by LoiTT on 12/14/14.
 */
static NSDateFormatter *dateTimeFormat;
+ (NSString *)convertDateTimeToString:(NSDate *)date {
    if (dateTimeFormat == nil) {
        NSString *strDateTimeFormat = @"dd/MM/yyyy HH:mm:ss";
        dateTimeFormat = [[NSDateFormatter alloc] init];
        dateTimeFormat.locale = [NSLocale systemLocale];
        [dateTimeFormat setDateFormat:strDateTimeFormat];
    }
    
    NSString *strDateTime = @"";
    if (date) {
        strDateTime = [dateTimeFormat stringFromDate:date];
    }
    return strDateTime;
}

/**
 Created by LoiTT on 12/14/14.
 */
static NSDateFormatter *timeFormat;
+ (NSString *)convertTimeToString:(NSDate *)date {
    if (timeFormat == nil) {
        timeFormat = [[NSDateFormatter alloc] init];
        timeFormat.locale = [NSLocale systemLocale];
        [timeFormat setDateFormat:@"HH:mm:ss"];
    }
    
    NSString *strTime = @"";
    if (date) {
        strTime = [timeFormat stringFromDate:date];
    }
    return strTime;
}

/**
 Created by LoiTT on 12/23/14.
 */
+ (NSDate*) dateFromJSONString:(NSString *)dateString {
    NSCharacterSet *charactersToRemove = [[ NSCharacterSet decimalDigitCharacterSet ] invertedSet ];
    NSString* milliseconds = [dateString stringByTrimmingCharactersInSet:charactersToRemove];
    
    if (milliseconds != nil && ![milliseconds isEqualToString:@"62135596800000"]) {
        NSTimeInterval  seconds = [milliseconds doubleValue] / 1000;
        return [NSDate dateWithTimeIntervalSince1970:seconds];
    }
    return nil;
}

/**
 Created by LoiTT on 12/14/14.
 */
+ (UIAlertView *)showAlertMessageWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    UIAlertView *alert = [self alertMessageWithTitle:title message:message delegate:delegate cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles];
    
    [alert show];
    return alert;
}

/**
 Created by LoiTT on 12/14/14.
 */
+ (UIAlertView *)alertMessageWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:delegate cancelButtonTitle:nil otherButtonTitles:nil];
    
    NSInteger cancelIndex = [alert addButtonWithTitle:cancelButtonTitle];
    [alert setCancelButtonIndex:cancelIndex];
    
    for (id titleButton in otherButtonTitles) {
        [alert addButtonWithTitle:[titleButton description]];
    }
    
    return alert;
}

/**
 Created by LoiTT on 12/14/14.
 */
+ (UIColor *)darkerColorForColor:(UIColor *)color withDarkerPercent:(float)percent {
    CGFloat r, g, b, a;
    if ([color getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r * percent, 0.0)
                               green:MAX(g * percent, 0.0)
                                blue:MAX(b * percent, 0.0)
                               alpha:a];
    return nil;
}

/**
 Created by LoiTT on 12/23/14.
 */
+ (NSString *)encryptPassword:(NSString *)password {
    NSString *base64EncryptedString = @"";
    
    // hash secret key using MD5 algorithm
    NSData *key = [SECRET_KEY MD5Data];
    
    // hash password using TripleDes algorithm
    NSData *passData = [password dataUsingEncoding:NSUTF16LittleEndianStringEncoding allowLossyConversion:NO];
    NSData *hashPass = [passData encryptedWithKey:key];
        
    // Base 64 hass pass
    base64EncryptedString = [hashPass base64EncodedString];
    return base64EncryptedString;
}
@end
