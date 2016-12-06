//
//  ViewController.m
//  WeChatFriendList
//
//  Created by 宇航 on 16/12/6.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "NSString+Utils.h"

@implementation NSString (Utils)

//汉字的拼音
- (NSString *)pinyin{
    NSMutableString *str = [self mutableCopy];
    CFStringTransform(( CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    
    return [str stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
