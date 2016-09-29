//
//  Utils.m
//  wordview
//
//  Created by xianjunming on 14-10-21.
//  Copyright (c) 2014年 Gamabao. All rights reserved.
//

#import "Utils.h"
#import "NSString+safe.h"
#import "SBJson4Writer.h"
#import "NSString+HMACSHA1.h"

@implementation Utils
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
//+ (UIImage*)generateCode:(NSString *)encodeable andSize:(CGSize)qrsize
//{
//    
//    return [QRCodeGenerator qrImageForString:encodeable imageSize:qrsize.width*2];
//    
//}


/**
 *  @Author xianjunming, 15-01-19 16:01:28
 *
 *  根据当前网络情况对图片进行压缩处理
 *
 *  @param imageDatas 源图片数组,压缩系数
 *
 *  @return 压缩后图片数组
 */

+ (UIImage *) imageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (NSString *)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *stateString = @"wifi";
    
    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;
            
        case 1:
            stateString = @"2G";
            break;
            
        case 2:
            stateString = @"3G";
            break;
            
        case 3:
            stateString = @"4G";
            break;
            
        case 4:
            stateString = @"LTE";
            break;
            
        case 5:
            stateString = @"wifi";
            break;
            
        default:
            break;
    }
    
    return stateString;
}

#pragma mark - 获取加密request
+ (NSMutableURLRequest *)getRequestWithParameter:(NSDictionary *)dict {
//    UserInfomation * myUserInfomation = [UserInfomation sharedInstance];
    NSString *URLTmp1 = [NSString getSafeWithTokenID:TOKENID dict:dict];
    
    /*
     *加密
     */
    
    NSMutableDictionary * dictMutable = [[NSMutableDictionary alloc]initWithDictionary:dict];
    
    SBJson4Writer * writer = [[SBJson4Writer alloc]init];
    
    NSString * json_str = [writer stringWithObject:[dict objectForKey:@"content"]];
    
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    
    NSString * time_str = [NSString stringWithFormat:@"%0.0f",time];
    
    
    NSInteger random = arc4random();
    
    NSString * random_str = [NSString stringWithFormat:@"%ld",(long)random];
    
    
    NSArray * array1 = @[TOKENID,json_str,time_str,random_str,SAFE_KEY];
    
    NSArray * sort = [array1 sortedArrayUsingSelector:@selector(compare:)];
    
    
    NSString * sort_str = [NSString stringWithFormat:@"[%@, %@, %@, %@, %@]",sort[0],sort[1],sort[2],sort[3],sort[4]];
    
    NSString * sha1 = [sort_str sha1];
    
    
    //    NSString * result = [NSString stringWithFormat:@"%@?time=%@&rd=%@&sign=%@",WebPageURL,time_str,random_str,sha1];
    
    [dictMutable setValue:time_str forKey:@"time"];
    [dictMutable setValue:random_str forKey:@"rd"];
    [dictMutable setValue:sha1 forKey:@"sign"];
    
    
    
    NSData * data = [NSJSONSerialization dataWithJSONObject:dictMutable options:0 error:nil];
    
    Byte * testByte = (Byte *)[data bytes];
    NSMutableData * dataXor = [[NSMutableData alloc]init];
    for (int i = 0; i < data.length; i ++) {
        Byte byteT[1];
        byteT[0] = testByte[i] ^ 0xff;
        [dataXor appendBytes:byteT length:1];
    }
    
    NSString* encodeResult = [dataXor base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLTmp1]];
    request.timeoutInterval = 15.0;
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Contsetent-Type"];
    [request setValue:@"wo56.com" forHTTPHeaderField:@"Encrypt-Code"];
    [request setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    [request setValue:[UIDevice currentDevice].model forHTTPHeaderField:@"User-Agent"];
    [request setHTTPBody:[encodeResult dataUsingEncoding:NSUTF8StringEncoding]];
    return request;
}

#pragma mark - 获取上传加密request
+ (NSMutableURLRequest *)getRequestWithParameter:(NSDictionary *)dict withImageData:(NSData *)imgData{
    
//    UserInfomation * myUserInfomation = [UserInfomation sharedInstance];
    
    NSString *URLTmp1 = [NSString getSafeWithTokenID:TOKENID dict:dict];
    
    /*
     *加密
     */
    
    NSMutableDictionary * dictMutable = [[NSMutableDictionary alloc]initWithDictionary:dict];
    
    SBJson4Writer * writer = [[SBJson4Writer alloc]init];
    
    NSString * json_str = [writer stringWithObject:[dict objectForKey:@"content"]];
    
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    
    NSString * time_str = [NSString stringWithFormat:@"%0.0f",time];
    
    
    NSInteger random = arc4random();
    
    NSString * random_str = [NSString stringWithFormat:@"%ld",(long)random];
    
    
    NSArray * array1 = @[TOKENID,json_str,time_str,random_str,SAFE_KEY];
    
    NSArray * sort = [array1 sortedArrayUsingSelector:@selector(compare:)];
    
    
    NSString * sort_str = [NSString stringWithFormat:@"[%@, %@, %@, %@, %@]",sort[0],sort[1],sort[2],sort[3],sort[4]];
    
    NSString * sha1 = [sort_str sha1];
    
    
    //    NSString * result = [NSString stringWithFormat:@"%@?time=%@&rd=%@&sign=%@",WebPageURL,time_str,random_str,sha1];
    
    [dictMutable setValue:time_str forKey:@"time"];
    [dictMutable setValue:random_str forKey:@"rd"];
    [dictMutable setValue:sha1 forKey:@"sign"];
    
    
    NSData * data = [NSJSONSerialization dataWithJSONObject:dictMutable options:0 error:nil];
    
    Byte * testByte = (Byte *)[data bytes];
    NSMutableData * dataXor = [[NSMutableData alloc]init];
    for (int i = 0; i < data.length; i ++) {
        Byte byteT[1];
        byteT[0] = testByte[i] ^ 0xff;
        [dataXor appendBytes:byteT length:1];
    }
    
    NSString* encodeResult = [dataXor base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSMutableURLRequest *request =
    [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLTmp1]];
    request.timeoutInterval = 15.0;
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Contsetent-Type"];
    [request setValue:@"wo56.com" forHTTPHeaderField:@"Encrypt-Code"];
    [request setValue:@"gzip,deflate" forHTTPHeaderField:@"Accept-Encoding"];
    [request setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    [request setValue:[UIDevice currentDevice].model forHTTPHeaderField:@"User-Agent"];
    
    
    NSMutableData *myRequestData = [[NSMutableData alloc] init];
    
    //分割符
    NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //http 参数body的字符串
    NSMutableString *paraBody=[[NSMutableString alloc]init];
    
    //添加分界线，换行
    [paraBody appendFormat:@"%@\r\n",MPboundary];
    //添加字段名称，换2行
    [paraBody appendFormat:@"Content-Disposition: form-data; name=json\r\n\r\n"];
    
    [paraBody appendFormat:@"%@\r\n",encodeResult];
    
    [myRequestData appendData:[paraBody dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSMutableString *imageBody = [[NSMutableString alloc] init];
    NSString *name = [NSString stringWithFormat:@"file"];
    NSString *fileNmae = [NSString stringWithFormat:@"imageFile.png"];
    //添加分界线，换行
    [imageBody appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    [imageBody appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",name,fileNmae];
    
    [imageBody appendFormat:@"Content-Type: image/jpge,image/gif, image/jpeg, image/pjpeg, image/pjpeg\r\n\r\n"];
    //将image的data加入
    
    [myRequestData appendData:[imageBody dataUsingEncoding:NSUTF8StringEncoding]];
    [myRequestData appendData:[[NSData alloc] initWithData:imgData]];
    [myRequestData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%lu", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    
    NSLog(@"%@",request.allHTTPHeaderFields);
    
    return request;
}
#pragma mark - 获取解密数据
+ (NSDictionary *)getResultWithData:(NSData *)data {
    NSData * decodeData = [[NSData alloc] initWithBase64EncodedData:data options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    Byte * testByte = (Byte *)[decodeData bytes];
    NSMutableData * dataXor = [[NSMutableData alloc]init];
    for (int i = 0; i < decodeData.length; i ++) {
        Byte byteT[1];
        byteT[0] = testByte[i] ^ 0xff;
        [dataXor appendBytes:byteT length:1];
    }
    
    NSDictionary * result = [NSJSONSerialization JSONObjectWithData:dataXor options:NSJSONReadingMutableContainers error:nil];
    return result;
}

#pragma mark  - 验证类型
/*邮箱验证*/
+(BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
//用于计算图片大小
+(NSInteger)setCalculatingPictureSize:(NSData *)image
{
    NSInteger sum=0;
    CGFloat scale=(image.length/1024);
    if (scale>300&&scale<=1000) {
        sum=1;
    }else if(scale>1000&&scale<=2000){
        sum=2;
    }else if (scale>2000){
        sum=3;
    }
    
    return sum;
    
}

/*手机号码验证*/
+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符  170开头的也判断为可以
    NSString *phoneRegex = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0,0-9])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//固话验证^(0(10|2[1-3]|[3-9]\d{2}))?[1-9]\d{6,7}$
+(BOOL) isValidateTel:(NSString *)tel
{
    NSString *TelRegex = @"^(0(10|2[1-3]|[3-9]\\d{2}))?[1-9]\\d{6,7}$";
    NSPredicate *TelTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",TelRegex];
    
    return [TelTest evaluateWithObject:tel];
}
//邮编验证[1-9]d{5}(?!d)   [1-9]d{5}（?!d）
+(BOOL) isValidatePostalcode:(NSString *)code
{
    NSString *codeRegex = @"^[1-9]\\d{5}$";
    NSPredicate *codeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    
    return [codeTest evaluateWithObject:code];
}

/*车牌号验证 */
+(BOOL)validateCarNo:(NSString*) carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[A-Za-z]{1}[A-Za-z_0-9]{5}$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//身份证验证d{15}|d{18}
+(BOOL)validateIdentityCarNo:(NSString*) carNo
{
    NSString *carRegex = @"\\d{15}|\\d{18}";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}
//护照^1[45][0-9]{7}|G[0-9]{8}|P[0-9]{7}|S[0-9]{7,8}|D[0-9]+$
+(BOOL)validatePassport:(NSString*) passport
{
    NSString *carRegex = @"^1[45][0-9]{7}|G[0-9]{8}|P[0-9]{7}|S[0-9]{7,8}|D[0-9]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:passport];
}
/* 是否纯数字*/
+ (BOOL)isNumText:(NSString *)str{
    NSString * regex        = @"^[0-9]{1,15}$";
    NSPredicate * pred      = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch            = [pred evaluateWithObject:str];
    if (isMatch) {
        return YES;
    }else{
        return NO;
    }
    
}
#pragma mark - base64加密
+(NSString *)base64Encrypt:(NSString *)password {
    
    NSString * str = [NSString stringWithFormat:@"%02d%@%02d{zx}",arc4random()%100,password,arc4random()%100];
    NSData * data1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data1 base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
}



#pragma mark - BAG图大图展示
+(NSString *)ThePictureURLWithBigURL:(NSString *)ThePicture
{
    NSArray *array;
    int sum=0;
    if([ThePicture rangeOfString:@".jpg"].location !=NSNotFound)
    {
        array=[ThePicture componentsSeparatedByString:@".jpg"];
        sum=0;
    }else if([ThePicture rangeOfString:@".png"].location !=NSNotFound){
        sum=1;
        array=[ThePicture componentsSeparatedByString:@".png"];
    }else if([ThePicture rangeOfString:@".gif"].location !=NSNotFound){
        sum=2;
        array=[ThePicture componentsSeparatedByString:@".gif"];
    }
    
    NSMutableString *string=[[NSMutableString alloc] init ];
    if (array.count==2) {
        [string appendString:array[0]];
        if (sum==0) {
            [string appendString:@"_big.jpg"];
        }else if(sum==1){
            [string appendString:@"_big.png"];
        }else if(sum==2){
            [string appendString:@"_big.gif"];
        }
        
    }else{
        [string appendString:ThePicture];
    }
    return string;
}

+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

/**
 * 绘制垂直虚线
 * @param lineView : 需要绘制成虚线的view
 * @param lineLength : 虚线的宽度
 * @param lineSpacing :	虚线的间距
 * @param lineColor : 虚线的颜色
 */
+ (void)drawVerticalDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor {
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) , CGRectGetHeight(lineView.frame) / 2)];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


//根据时间返回时间戳
+(NSString *)intFromDate:(NSString *)dateString
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[self dateFromString:dateString] timeIntervalSince1970]];
    return timeSp;
}
+(NSDate *)dateFromString:(NSString *)dateString{
    //    NSString *dateString = @"2015-04-02";
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyy-MM-dd"];
    NSDate *destDate = [dateFormater dateFromString: dateString];
    
    return destDate;
}

+(NSString *)stringFromDate:(NSDate *)date{
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    return destDateString;
    
}


//拨打电话
+(void)phoneCallEvent:(NSString*) phoneStr{
    
    if ([phoneStr isEqualToString:@""]) {
        
//        AlertShowWithMessage(@"号码为空,不能拨打!", @"", @"确定", nil, nil);
        
    }else{
        
        NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"tel:%@",phoneStr];
        NSMutableString * str2 = [[NSMutableString alloc] initWithFormat:@"电话号码:%@",phoneStr];
//        AlertShowWithMessage(str2, @"取消", @"立即拨打", nil, ^{
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//        });
        
    };
    
}



@end
