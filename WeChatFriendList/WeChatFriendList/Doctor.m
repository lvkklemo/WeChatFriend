//
//  Doctor.m
//  WeChatFriendList
//
//  Created by 宇航 on 16/12/6.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "Doctor.h"
#import "NSString+Utils.h"

@implementation Doctor
- (void)setFullName:(NSString *)fullName{
    if (fullName) {
        _fullName = fullName;
        _pinyin=_fullName.pinyin;
    }
}
@end
