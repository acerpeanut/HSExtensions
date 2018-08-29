//
//  HSValidateTool.m
//  WarmCar
//
//  Created by admin  on 2017/12/28.
//  Copyright © 2017年 GangQinPeng. All rights reserved.
//

#import "HSValidateTool.h"

@implementation HSValidateTool

#pragma mark - 限制输入框文字长度
+ (void)RestrictTextField:(UITextField *)textField ToMaxLength:(NSInteger)maxLength {
    NSString *toBeString = textField.text;
    NSString *lang = [[textField textInputMode] primaryLanguage]; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            //---字符处理
            if (toBeString.length > maxLength){
                //中文和emoj表情存在问题，需要对此进行处理
                NSRange range;
                NSUInteger inputLength = 0;
                for(int i=0; i < toBeString.length && inputLength <= maxLength; i += range.length) {
                    range = [textField.text rangeOfComposedCharacterSequenceAtIndex:i];
                    inputLength += [toBeString substringWithRange:range].length;
                    if (inputLength > maxLength) {
                        NSString* newText = [toBeString substringWithRange:NSMakeRange(0, range.location)];
                        textField.text = newText;
                    }
                }
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else {
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > maxLength) {
            textField.text = [toBeString substringToIndex:maxLength];
        }
    }
}

+ (void)textFieldDisableEmoji:(UITextField *)textField {
    NSString *newText = [self disable_emoji:textField.text];
    if (! [newText isEqualToString:textField.text]) {
        textField.text = newText;
    }
}

+ (void)textViewDisableEmoji:(UITextView *)textView {
    NSString *newText = [self disable_emoji:textView.text];
    if (! [newText isEqualToString:textView.text]) {
        NSRange textRange = [textView selectedRange];
        [textView setText:[self disable_emoji:newText]];
        [textView setSelectedRange:textRange];
    }
}

+ (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

#pragma mark - 身份证
//身份证号（大陆/港澳台）
+ (BOOL)CheckIsValidIdentityCard:(NSString *)identityCard {
//    return [self CheckIsChinaIdentityCard:identityCard] || [self CheckIsGangAoTaiCard:identityCard];
    return [self CheckIsValidIdentityCardLoosely:identityCard];
}

//检查身份证号是否有效（宽松的）
+ (BOOL)CheckIsValidIdentityCardLoosely:(NSString *)identityCard {
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    } else if (identityCard.length > 30) {
        return NO;
    } else {
        NSString *regex = @"^[A-Za-z0-9\\(\\)（）<>-]+$";
        NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
        if(![identityCardPredicate evaluateWithObject:identityCard]){
            return NO;
        }
    }
    return YES;
}

//身份证号（大陆）
+ (BOOL)CheckIsChinaIdentityCard:(NSString *)identityCard
{
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

//身份证号（港澳台）
+ (BOOL)CheckIsGangAoTaiCard:(NSString *)identityCard {
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    NSString *regexGang = @"^[A-Z][0-9]{9}$";
    NSString *regexAo = @"^[A-Z][0-9]{6}\\([0-9A]\\)$";
    NSString *regexTai = @"^[157][0-9]{6}\\(?[0-9]\\)?$";
    NSPredicate *identityCardPredicateGang = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexGang];
    NSPredicate *identityCardPredicateAo = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexAo];
    NSPredicate *identityCardPredicateTai = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regexTai];
    if([identityCardPredicateGang evaluateWithObject:identityCard]){ // 港
        return YES;
    } else if ([identityCardPredicateAo evaluateWithObject:identityCard]){ // 澳
        return YES;
    } else if ([identityCardPredicateTai evaluateWithObject:identityCard]){ // 台
        return YES;
    }
    return NO;
}

#pragma mark - 手机号码
// 是不是合法号码
+ (BOOL)isPhoneLegal:(NSString *)phoneNum {
    return [self isChinaPhoneLegal:phoneNum] || [self isHKPhoneLegal:phoneNum];
}
// 是不是中国号码
+ (BOOL)isChinaPhoneLegal:(NSString *)phoneNum {
    phoneNum = [phoneNum stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^((13[0-9])|(15[^4])|(16[0-9])|(17[0-8])|(18[0-9])|(19[0-9])|(145)|(147)|(149)|)\\d{8}$"];
    BOOL isChinaPhone = [phoneTest evaluateWithObject:phoneNum];
    return isChinaPhone;
}
// 是不是香港号码
+ (BOOL)isHKPhoneLegal:(NSString *)phoneNum {
    NSPredicate* phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^(5|6|8|9)\\d{7}$"];
    BOOL isHKPhone = [phoneTest evaluateWithObject:phoneNum];
    return isHKPhone;
}

@end
