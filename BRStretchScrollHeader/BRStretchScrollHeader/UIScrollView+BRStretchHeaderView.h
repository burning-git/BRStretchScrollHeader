//
//  UIScrollView+BRStretchHeaderView.h
//  BRTablewStretchHeader
//
//  Created by gitBurning on 16/12/8.
//  Copyright © 2016年 BR. All rights reserved.
//

#import "BRStretchScrollHeader.h"
@interface UIScrollView (BRStretchHeaderView)

@property (nonatomic, assign) CGFloat br_headerViewHeight;
/**
 增加 stretchHeaderView （ps ，如果有偏移量是 64的话 ,请设置  viewController.automaticallyAdjustsScrollViewInsets = NO;）

 @param headerView <#headerView description#>
 */
- (void)BR_addStrechHeaderView:(UIView *)headerView;


/**
 增加 offset 变化block

 @param block <#block description#>
 */
- (void)BR_addContentOffsetBlcok:(void(^)(CGPoint point,UIScrollView *view))block;
@end
