//
//  WCTableViewBaseDataUtil.m
//  WarmCar
//
//  Created by admin  on 2018/4/11.
//  Copyright © 2018年 GangQinPeng. All rights reserved.
//

#import "WCTableViewBaseDataUtil.h"

@implementation WCTableViewBaseDataUtil

#pragma mark - DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.row < self.dataArray.count) {
        id obj = self.dataArray[indexPath.row];
        if (self.cellFor) {
            cell = self.cellFor(tableView, obj, indexPath);
        }
    } else {
        NSLog(@"error: indexPath超出范围了");
    }
    return cell ?: [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@""];
}

#pragma mark - Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row < self.dataArray.count) {
        id obj = self.dataArray[indexPath.row];
        if (self.didSelectRow) {
            self.didSelectRow(tableView, obj, indexPath);
        }
    } else {
        NSLog(@"error: indexPath超出范围了");
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArray.count) {
        id obj = self.dataArray[indexPath.row];
        if (self.heightForRow) {
            return self.heightForRow(tableView, obj, indexPath);
        }
    } else {
        NSLog(@"error: indexPath超出范围了");
    }
    return tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.heightForHeader) {
        return self.heightForHeader(tableView, section);
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.heightForFooter) {
        return self.heightForFooter(tableView, section);
    }
    return CGFLOAT_MIN;
}

@end
