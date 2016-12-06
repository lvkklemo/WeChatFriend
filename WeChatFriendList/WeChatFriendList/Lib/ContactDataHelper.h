//
//  ViewController.m
//  WeChatFriendList
//
//  Created by 宇航 on 16/12/6.
//  Copyright © 2016年 KH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 *  格式化联系人列表
 */

@interface ContactDataHelper : NSObject

+ (NSMutableArray *) getFriendListDataBy:(NSMutableArray *)array;
+ (NSMutableArray *) getFriendListSectionBy:(NSMutableArray *)array;

@end
