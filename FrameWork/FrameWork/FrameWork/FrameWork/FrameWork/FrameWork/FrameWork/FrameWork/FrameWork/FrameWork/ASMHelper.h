//
//  ASMHelper.h
//  mASM
//
//  Created by LoiTT on 12/14/14.
//  Copyright (c) 2014 FPT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 @class ASMHelper
 @inherits NSObject
 @description Ho tro chuyen doi du lieu va cac phuong thuc ho tro.
 */
@interface ASMHelper : NSObject

/**
 @method localizedStringWithKey:
 @description Lay chuoi localized cua key truyen vao.
 @param key: text ID
 @returns chuoi localize.
 */
+ (NSString *)localizedStringWithKey:(NSString *)key;

/**
 @method convertAmountToString:
 @description Chuyen doi so tien thanh chuoi dinh dang #.###.### VND
 @param amount:(NSNumber) so tien
 @returns chuoi so tien theo dinh dang.
 */
+ (NSString *)convertAmountToString:(NSNumber *)amount;

/**
 @method formatAmountString:
 @description Chuyen doi so tien thanh chuoi dinh dang #.###.###
 @param string:(NSString) chuoi so tien
 @returns chuoi so tien theo dinh dang.
 */
+ (NSString *)formatAmountString:(NSString *)string;

/**
 @method convertDateToString:
 @description Chuyen doi ngay thanh chuoi theo dinh dang dd/MM/yyyy.
 @param date:(NSDate) Ngay can chuyen
 @returns chuoi ngay.
 */
+ (NSString *)convertDateToString: (NSDate *)date;

/**
 @method convertDateTimeToString:
 @description Chuyen doi ngay gio thanh chuoi theo dinh dang dd/MM/yyyy HH:mm:ss.
 @param date:(NSDate) Ngay gio can chuyen
 @returns chuoi ngay gio.
 */
+ (NSString *)convertDateTimeToString: (NSDate *)date;

/**
 @method convertTimeToString:
 @description Chuyen doi gio thanh chuoi theo dinh dang HH:mm:ss.
 @param date:(NSDate) Gio can chuyen
 @returns chuoi gio.
 */
+ (NSString *)convertTimeToString: (NSDate *)date;

/**
 @method convertStringToDate:
 @description Chuyen doi chuoi ngay thanh doi tuong NSDate theo dinh dang dd/MM/yyyy.
 @param strDate:(NSString) Chuoi ngay can chuyen
 @returns Doi tuong NSdate.
 */
+ (NSDate *)convertStringToDate:(NSString *)strDate;

/**
 @method convertStringDateToDate:
 @description Chuyen doi chuoi ngay gio thanh doi tuong theo dinh dang dd/MM/yyyy HH:mm:ss.
 @param strDateTime:(NSString) Chuoi thoi gian can chuyen
 @returns Doi tuong NSdate.
 */
+ (NSDate *)convertStringToDateTime:(NSString *)strDateTime;

+ (NSDate *)dateFromJSONString:(NSString *)dateString;

/**
 @method showAlertMessageinitWithTitle: message: delegate: cancelButtonTitle: otherButtonTitles:
 @description Chuyen doi gio thanh chuoi theo dinh dang company config.
 @param title: Tieu de alert
 @param message: Noi dung hien thi
 @param delegate: Delegate cho alert view
 @param cancelButtonTitle: Text button cancel
 @param otherButtonTitles: Text cac button khac
 @returns Alert view.
 */
+ (UIAlertView *)showAlertMessageWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

/**
 @method darkerColorForColor: withDarkerPercent:
 @description Chuyen doi sang toi mau.
 @param color: Mau goc
 @param percent: Phan tram lam toi
 @returns Mau da chuyen doi.
 */
+ (UIColor *)darkerColorForColor:(UIColor *)color withDarkerPercent:(float)percent;

+ (NSString *)encryptPassword:(NSString *)password;
@end
