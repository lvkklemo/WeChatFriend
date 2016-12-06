//
//  ContactModel.h
//  WeChatFriendList
//
//  Created by 宇航 on 16/12/6.
//  Copyright © 2016年 KH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Doctor.h"
@interface ContactModel : NSObject

//@property (nonatomic, assign) NSUInteger doctorCooperationId;
@property (nonatomic, assign) NSUInteger doctorRelationshipId;
@property (nonatomic, assign) NSUInteger sourceDoctorId;
@property (nonatomic, assign) NSUInteger destinationDoctorId;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *createdDate;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, strong) Doctor *relatedDoctor;
@end
