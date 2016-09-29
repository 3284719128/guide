//
//  Utils.h
//  wordview
//
//  Created by xianjunming on 14-10-21.
//  Copyright (c) 2014年 Gamabao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "QRCodeGenerator.h"


@interface Utils : NSObject



/**
 *  @Author xianjunming,
 *
 *  生成二维码图片UIImage
 *
 *  @param encodeable 二维码内容
 *  @param qrsize     二维码尺寸大小
 *
 *  @return UIImage
 */
+ (UIImage*)generateCode:(NSString *)encodeable andSize:(CGSize)qrsize;

/**
 *  @Author xianjunming, 15-01-19 16:01:28
 *
 *  根据当前网络情况对图片进行压缩处理
 *
 *  @param imageDatas 源图片数组,压缩系数
 *
 *  @return 压缩后图片数组
 */

+ (UIImage *) imageWithView:(UIView *)view;



/*
 *      获取当前网络情况
 *
 *
 *
 */
#pragma mark - 获取网络状态

+ (NSString *)networkingStatesFromStatebar;
#pragma mark - 获取加密request
+ (NSMutableURLRequest *)getRequestWithParameter:(NSDictionary *)dict;

#pragma mark - 获取上传加密request
+ (NSMutableURLRequest *)getRequestWithParameter:(NSDictionary *)dict withImageData:(NSData *)imgData;

#pragma mark - 获取解密数据

+ (NSDictionary *)getResultWithData:(NSData *)data;

#pragma mark 验证工具
/*车牌号验证*/
+(BOOL)validateCarNo:(NSString*) carNo;
/*手机号码验证 */
+(BOOL) isValidateMobile:(NSString *)mobile;
/*邮箱验证*/
+(BOOL)isValidateEmail:(NSString *)email;
/*固话验证*/
+(BOOL) isValidateTel:(NSString *)tel;
/*邮政编码验证*/
+(BOOL) isValidatePostalcode:(NSString *)code;
/*身份证验证*/
+(BOOL)validateIdentityCarNo:(NSString*) carNo;
/*护照验证*/
+(BOOL)validatePassport:(NSString*) passport;
/* 是否纯数字*/
+ (BOOL)isNumText:(NSString *)str;




#pragma mark - base64加密
+(NSString *)base64Encrypt:(NSString *)password;






/*
 *用于计算图片大小
 *
 *
 */
+(NSInteger)setCalculatingPictureSize:(NSData *)image;


/*
 *Bag图大图展示
 *
 *
 */

+(NSString *)ThePictureURLWithBigURL:(NSString *)ThePicture;

/*
 *画虚线
 *
 *
 */
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

+ (void)drawVerticalDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;


/*
 *
 *根据时间返回时间戳
 **/
+(NSString *)intFromDate:(NSString *)dateString;

//传data返回字符串
+(NSDate *)dateFromString:(NSString *)dateString;
//传字符串返回data
+(NSString *)stringFromDate:(NSDate *)date;

//拨打电话
+(void)phoneCallEvent:(NSString*) phoneStr;



@end


