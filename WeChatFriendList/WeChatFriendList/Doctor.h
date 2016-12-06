//
//  Doctor.h
//  WeChatFriendList
//
//  Created by 宇航 on 16/12/6.
//  Copyright © 2016年 KH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Doctor : NSObject
@property (nonatomic, copy) NSString *fullName;
@property (nonatomic, copy) NSString *kauriHealthId;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic,copy) NSString *pinyin;//拼音
@end
