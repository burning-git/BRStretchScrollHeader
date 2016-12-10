//
//  UIViewController+BRStretchHeaderView.h
//  BRStretchScrollHeader
//
//  Created by gitBurning on 16/12/9.
//  Copyright © 2016年 BR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BRStretchScrollHeader.h"




/**
 导航栏 状态

 - kBRViewControllerStretchHeaderViewNavBarStatus_NotShow:  未显示 alpha = 0
 - kBRViewControllerStretchHeaderViewNavBarStatus_WillShow: 将要显示 alpha (0~1)
 - kBRViewControllerStretchHeaderViewNavBarStatus_DidShow:  已显示  alpha = 1
 */
typedef NS_ENUM(NSUInteger, kBRViewControllerStretchHeaderViewNavBarStatus) {
    kBRViewControllerStretchHeaderViewNavBarStatus_NotShow,
    kBRViewControllerStretchHeaderViewNavBarStatus_WillShow,
    kBRViewControllerStretchHeaderViewNavBarStatus_DidShow
};
@interface UIViewController (BRStretchHeaderView)

@property (nonatomic, strong) UINavigationBar *br_navBar;
@property (nonatomic, strong , readonly) UINavigationItem *br_navigationItem;
@property (nonatomic, assign , readonly) kBRViewControllerStretchHeaderViewNavBarStatus navBarStatus;

/**
 viewController 增加 BRStretchHeaderView

 @param headerView headerView
 @param tablew     tablew
 */
- (void)BR_addVCStrechHeaderView:(UIView *)headerView InTablewView:(UITableView *)tablew;


/**
 导航栏透明度变化 blcok

 @param blcok <#blcok description#>
 */
- (void)BR_addVCNavBarStatusChangedBlcok:(void(^)(kBRViewControllerStretchHeaderViewNavBarStatus staus, CGFloat alpha))blcok;


/**
 自定义滑动变化导航栏透明事件, 覆盖自带的滑动改变处理事件

 @param block <#block description#>
 */
- (void)BR_addCustomScrollEventBlock:(void(^)(CGPoint point,UIScrollView *scrollView))block;
@end
