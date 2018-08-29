//
//  WCTableViewDataSource.m
//  WarmCar
//
//  Created by admin  on 2018/4/11.
//  Copyright © 2018年 GangQinPeng. All rights reserved.
//

#import "WCTableViewDataUtil.h"

#import <objc/runtime.h>

#pragma mark - WCTableViewDataUtilConfigureModel
@interface WCTableViewDataUtilConfigureModel : NSObject
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) BOOL (^switchCase)(id obj);
@property (nonatomic, copy) void (^cellBlock)(UITableViewCell *cell, id obj);
@property (nonatomic, copy) void (^selectBlock)(__kindof UITableView *tableView, id __nonnull obj, NSIndexPath *indexPath);
@property (nonatomic, strong) NSMutableSet *objSet;
@end

@implementation WCTableViewDataUtilConfigureModel

@end

@interface WCTableViewDataUtil ()
@property (nonatomic, strong) NSMutableArray<WCTableViewDataUtilConfigureModel*> *configureArray;
@end

#pragma mark - WCTableViewDataUtil
@implementation WCTableViewDataUtil

- (instancetype)init {
    if (self = [super init]) {
        __weak typeof(self) weakSelf = self;
        self.cellFor = ^UITableViewCell *(UITableView *tableView, id  _Nonnull model, NSIndexPath *indexPath) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            __block UITableViewCell *cell = nil;
            [strongSelf.configureArray enumerateObjectsUsingBlock:^(WCTableViewDataUtilConfigureModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.switchCase == nil || obj.switchCase(model)) {
                    cell = [tableView dequeueReusableCellWithIdentifier:obj.identifier];
                    if (cell && obj.cellBlock) {
                        [obj.objSet addObject:model];
                        obj.cellBlock(cell, model);
                    }
                    *stop = YES;
                }
            }];
            return cell;
        };
        
        self.didSelectRow = ^(UITableView *tableView, id  _Nonnull model, NSIndexPath *indexPath) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf.configureArray enumerateObjectsUsingBlock:^(WCTableViewDataUtilConfigureModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.objSet containsObject:model]) {
                    if (model && obj.selectBlock) {
                        obj.selectBlock(tableView, model, indexPath);
                    }
                    *stop = YES;
                }
            }];
        };
    }
    return self;
}

- (void)registerCellClass:(Class)cellClass identifier:(NSString *)identifier forTableView:(UITableView *)tableView {
    [tableView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerCellNib:(NSString *)nibName identifier:(NSString *)identifier forTableView:(UITableView *)tableView {
    [tableView registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:identifier];
}

- (void)configureCellWithSwitchCase:(BOOL (^)(id))switchCase identifier:(NSString *)identifier cellBlock:(void (^)(__kindof UITableViewCell *, id _Nonnull))cellBlock {
    [self configureCellWithSwitchCase:switchCase identifier:identifier cellBlock:cellBlock selectBlock:nil];
}

- (void)configureCellWithSwitchCase:(BOOL (^)(id))switchCase
                         identifier:(NSString *)identifier
                          cellBlock:(void (^)(__kindof UITableViewCell *, id _Nonnull))cellBlock
                        selectBlock:(void (^)(__kindof UITableView *, id _Nonnull, NSIndexPath *))selectBlock {
    if (identifier == nil || cellBlock == nil) {
        return;
    }
    WCTableViewDataUtilConfigureModel *configureModel = [[WCTableViewDataUtilConfigureModel alloc] init];
    configureModel.identifier = identifier;
    configureModel.switchCase = switchCase;
    configureModel.cellBlock = cellBlock;
    configureModel.selectBlock = selectBlock;
    configureModel.objSet = [NSMutableSet set];
    
    if (!_configureArray) {
        _configureArray = [NSMutableArray array];
    }
    [_configureArray addObject:configureModel];
}

@end

@implementation UITableView (WCTableViewDataUtil)

static char kWC_DATAUTILKey = 0;

- (void)setWc_dataUtil:(WCTableViewDataUtil *)wc_dataUtil {
    objc_setAssociatedObject(self, &kWC_DATAUTILKey, wc_dataUtil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (WCTableViewDataUtil *)wc_dataUtil {
    return objc_getAssociatedObject(self, &kWC_DATAUTILKey);
}

- (WCTableViewDataUtil *)wc_makeDataUtilWithDataArray:(NSArray *)dataArray {
    WCTableViewDataUtil *dataUtil = [self wc_dataUtil] ?: [[WCTableViewDataUtil alloc] init];
    dataUtil.dataArray = dataArray;
    self.dataSource = dataUtil;
    self.delegate = dataUtil;
    [self setWc_dataUtil:dataUtil];
    return dataUtil;
}

- (void)wc_reloadWithDataArray:(NSArray *)dataArray {
    self.wc_dataUtil.dataArray = dataArray;
    [self reloadData];
}

@end
