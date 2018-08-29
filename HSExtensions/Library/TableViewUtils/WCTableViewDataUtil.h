//
//  WCTableViewDataSource.h
//  WarmCar
//
//  Created by admin  on 2018/4/11.
//  Copyright © 2018年 GangQinPeng. All rights reserved.
//

#import "WCTableViewBaseDataUtil.h"


@interface WCTableViewDataUtil<ObjectType> : WCTableViewBaseDataUtil<ObjectType>

- (void)registerCellClass:(Class)cellClass identifier:(NSString *)identifier forTableView:(UITableView *)tableView;
- (void)registerCellNib:(NSString *)nibName identifier:(NSString *)identifier forTableView:(UITableView *)tableView;

/**
 配置每个cell (覆盖了cellFor属性)
 
 
 @param switchCase 根据obj判断是否生成这个identifier的cell (block为nil或返回YES时生成)
 @param identifier cell的identifier
 @param cellBlock 成功生成cell后，使用obj对cell配置
 */
- (void)configureCellWithSwitchCase:(BOOL (^__nullable)(ObjectType obj))switchCase
                         identifier:(NSString * __nonnull)identifier
                          cellBlock:(void (^__nonnull)(__kindof UITableViewCell *cell, ObjectType __nonnull model))cellBlock;

/**
 配置每个cell (覆盖了cellFor属性)
 
 
 @param switchCase 根据obj判断是否生成这个identifier的cell (block为nil或返回YES时生成)
 @param identifier cell的identifier
 @param cellBlock 成功生成cell后，使用obj对cell配置
 @param selectBlock 选中cell后执行selectBlock
 */
- (void)configureCellWithSwitchCase:(BOOL (^__nullable)(ObjectType obj))switchCase
                         identifier:(NSString * __nonnull)identifier
                          cellBlock:(void (^__nonnull)(__kindof UITableViewCell *cell, ObjectType __nonnull model))cellBlock
                        selectBlock:(void (^)(__kindof UITableView *tableView, ObjectType __nonnull model, NSIndexPath *indexPath))selectBlock;

@end


@interface UITableView (WCTableViewDataUtil)

@property (nonatomic, strong, readonly) WCTableViewDataUtil *wc_dataUtil;

- (WCTableViewDataUtil *)wc_makeDataUtilWithDataArray:(NSArray *)dataArray;
- (void)wc_reloadWithDataArray:(NSArray *)dataArray;

@end
