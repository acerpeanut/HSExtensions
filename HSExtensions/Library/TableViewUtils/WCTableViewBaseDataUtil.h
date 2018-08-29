//
//  WCTableViewBaseDataUtil.h
//  WarmCar
//
//  Created by admin  on 2018/4/11.
//  Copyright © 2018年 GangQinPeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WCTableViewBaseDataUtil<__covariant ObjectType> : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, copy) UITableViewCell *(^cellFor)(UITableView *tableView, ObjectType __nonnull obj, NSIndexPath *indexPath);
@property (nonatomic, copy) void (^didSelectRow)(UITableView *tableView, ObjectType __nonnull obj, NSIndexPath *indexPath);
@property (nonatomic, copy) CGFloat (^heightForRow)(UITableView *tableView, ObjectType __nonnull obj, NSIndexPath *indexPath);
@property (nonatomic, copy) CGFloat (^heightForHeader)(UITableView *tableView, NSInteger section);
@property (nonatomic, copy) CGFloat (^heightForFooter)(UITableView *tableView, NSInteger section);

@end
