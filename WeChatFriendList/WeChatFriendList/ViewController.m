//
//  ViewController.m
//  WeChatFriendList
//
//  Created by 宇航 on 16/12/6.
//  Copyright © 2016年 KH. All rights reserved.
//

#import "ViewController.h"
#import "ContactModel.h"
#import "MJExtension.h"
#import "ContactDataHelper.h"
#import "ContactTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *rowArr;//row arr
@property (nonatomic,strong) NSArray *sectionArr;//section arr
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *json;
@property (nonatomic,strong) UISearchBar *searchBar;//搜索框
@property (nonatomic,strong) NSMutableArray *dataArr;
//@property (nonatomic,strong) UISearchDisplayController *searchDisplayController;//搜索VC
@end
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNav];
    [self setUpData];
    [self setUpView];
    
    _rowArr=[ContactDataHelper getFriendListDataBy:self.dataArr];
    _sectionArr=[ContactDataHelper getFriendListSectionBy:[_rowArr mutableCopy]];
    NSLog(@"%@",_rowArr);
    NSLog(@"----%@----",_sectionArr);
}
#pragma mark - setUpView
- (void)setUpView{
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0.0, kScreenHeight-49.0, kScreenWidth, 49.0)];
    [imageView setImage:[UIImage imageNamed:@"footerImage"]];
    [imageView setContentMode:UIViewContentModeScaleToFill];
    [self.view addSubview:imageView];
    
    [self.view insertSubview:self.tableView belowSubview:imageView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0.0, 0.0, kScreenWidth, kScreenHeight-49.0) style:UITableViewStylePlain];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView setSectionIndexBackgroundColor:[UIColor clearColor]];
        [_tableView setSectionIndexColor:[UIColor darkGrayColor]];
        [_tableView setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
        _tableView.tableHeaderView=self.searchBar;
        //cell无数据时，不显示间隔线
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView setTableFooterView:v];
    }
    return _tableView;
}
- (void)configNav{
 
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar_bg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0.0, 0.0, 30.0, 30.0)];
    [btn setBackgroundImage:[UIImage imageNamed:@"contacts_add_friend"] forState:UIControlStateNormal];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:btn]];
}

- (void)setUpData{
    self.dataArr=[NSMutableArray array];
    self.dataArr = [ContactModel mj_objectArrayWithKeyValuesArray:self.json];
    NSLog(@"%@",self.dataArr);
    
}

#pragma mark - UITableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //section
        return _rowArr.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //row

        return [_rowArr[section] count];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
        return _sectionArr;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //viewforHeader
    id label = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headerView"];
    if (!label) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14.5f]];
        [label setTextColor:[UIColor grayColor]];
        [label setBackgroundColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]];
    }
    [label setText:[NSString stringWithFormat:@"  %@",_sectionArr[section+1]]];
    return label;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index-1;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   
        return 22.0;

}

#pragma mark - UITableView dataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIde=@"cellIde";
    ContactTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIde];
    if (cell==nil) {
        cell=[[ContactTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
        ContactModel *model=_rowArr[indexPath.section][indexPath.row];
        [cell.headImageView setImage:[UIImage imageNamed:model.relatedDoctor.avatar]];
        [cell.nameLabel setText:model.relatedDoctor.fullName];
  
    
    return cell;
}


#pragma mark - dataArr(模拟从服务器获取到的数据)
- (NSArray *)json{
    if (!_json) {
        _json = @[
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                @"doctorId": @5765,
                @"avatar": @"1",
                @"email": @"null",
                @"fullName": @"吕可乐",
                @"totalCredit": @0.000,
                @"availableCredit": @0.000
                }},
        
         @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                 @"doctorId": @5765,
                 @"avatar": @"2",
                 @"email": @"null",
                 @"fullName": @"王加友",
                 @"totalCredit": @0.000,
                 @"availableCredit": @0.000
                }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"3",
                    @"email": @"null",
                    @"fullName": @"白百合",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"4",
                    @"email": @"null",
                    @"fullName": @"陈思成",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"5",
                    @"email": @"null",
                    @"fullName": @"黛丽丝",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"6",
                    @"email": @"null",
                    @"fullName": @"富联路",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"7",
                    @"email": @"null",
                    @"fullName": @"以为",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"8",
                    @"email": @"null",
                    @"fullName": @"哈了喔",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"9",
                    @"email": @"null",
                    @"fullName": @"刚刚好",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"10",
                    @"email": @"null",
                    @"fullName": @"可可",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"11",
                    @"email": @"null",
                    @"fullName": @"郑州",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"12",
                    @"email": @"null",
                    @"fullName": @"应用",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"13",
                    @"email": @"null",
                    @"fullName": @"格林",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"1",
                    @"email": @"null",
                    @"fullName": @"汤姆森",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"16",
                    @"email": @"null",
                    @"fullName": @"阿拉雷",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"12",
                    @"email": @"null",
                    @"fullName": @"沐沐",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"2",
                    @"email": @"null",
                    @"fullName": @"伍佰",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"9",
                    @"email": @"null",
                    @"fullName": @"艾利",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"15",
                    @"email": @"null",
                    @"fullName": @"星巴伦",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
        @{
            @"doctorRelationshipId": @4588,
            @"sourceDoctorId": @17428,
            @"destinationDoctorId": @5765,
            @"status": @"接受",
            @"createdDate": @"2016-11-21T15:41:38+08:00",
            @"comment": @"我是2016",
            @"relatedDoctor": @{
                    @"doctorId": @5765,
                    @"avatar": @"16",
                    @"email": @"null",
                    @"fullName": @"金莎",
                    @"totalCredit": @0.000,
                    @"availableCredit": @0.000
                    }},
                  ];
                }
    return _json;
}


@end
