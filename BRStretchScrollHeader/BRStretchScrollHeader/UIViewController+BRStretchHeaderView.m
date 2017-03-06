//
//  UIViewController+BRStretchHeaderView.m
//  BRStretchScrollHeader
//
//  Created by gitBurning on 16/12/9.
//  Copyright © 2016年 BR. All rights reserved.
//

#import "UIViewController+BRStretchHeaderView.h"
#import "BRStretchScrollHeader.h"
#import <objc/runtime.h>

static NSString *kBRCustomNavBar = @"kBRCustomNavBar";
static NSString *kBRCustomNavigationItem = @"kBRCustomNavigationItem";
//滑动监听block
static NSString *kBRCustomNavigationChangedBlcokKey = @"kBRCustomNavigationChangedBlcokKey";
//滑动状态
static NSString *kBRCustomNavigationStatusKey = @"kBRCustomNavigationStatusKey";
//自定义滑动改变事件导航栏
static NSString *kBRCustomNavigationCustomChangedKey = @"kBRCustomNavigationCustomChangedKey";

static NSString *kBRCustomNavigationBgColorKey = @"kBRCustomNavigationBgColorKey";
static NSString *kBRCustomNavigationStrechAutoFitFrameKey = @"kBRCustomNavigationStrechAutoFitFrameKey";


const NSInteger kBR_NavHeight = 64.0;

@interface UIViewController()

@property (nonatomic ,copy) void(^alphaBlcok)(kBRViewControllerStretchHeaderViewNavBarStatus staus, CGFloat alpha);

@property (nonatomic ,copy) void(^customEventChangeBlcok)(CGPoint point,UIScrollView *scrollView);

@property (nonatomic ,strong ) UIColor *br_navBarBgColor;
@end

@implementation UIViewController (BRStretchHeaderView)


#pragma mark -- interface

/*FIXME:  viewController 增加 BRStretchHeaderView */
- (void)BR_addVCStrechHeaderView:(UIView *)headerView InTablewView:(UITableView *)tablew {
    

    self.br_navBarBgColor = self.br_navBarBgColor ?:[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.fd_prefersNavigationBarHidden = YES;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self.navigationController performSelector:@selector(fd_setupViewControllerBasedNavigationBarAppearanceIfNeeded:) withObject:self];
#pragma clang diagnostic pop
    
    tablew.br_strechType = BRStretchHeaderStrechType_Default;
    [tablew BR_addStrechHeaderView:headerView];
    
    UINavigationBar *nav = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kBR_NavHeight)];
    UINavigationItem *br_navigationItem = [[UINavigationItem alloc] initWithTitle:self.navigationItem.title];
    [nav setItems:@[br_navigationItem]];
    self.br_navigationItem = br_navigationItem;
    [self.view addSubview:nav];
    [nav setShadowImage:[UIImage new]];
    self.br_navBar = nav;
    
    //设置透明
    [self.br_navBar lt_setBackgroundColor:[UIColor clearColor]];
    self.br_navBar.clipsToBounds  = YES;

    __weak UIViewController * weakSelf = self;
    [tablew BR_addContentOffsetBlcok:^(CGPoint point, UIScrollView *view) {
        
        [weakSelf br_scrollViewDidScroll:view];
    }];
}


/*FIXME:  导航栏透明度变化 blcok */
- (void)BR_addVCNavBarStatusChangedBlcok:(void (^)(kBRViewControllerStretchHeaderViewNavBarStatus, CGFloat))blcok {
    
    self.alphaBlcok = blcok;
}


/*FIXME:  自定义滑动变化事件, 覆盖自带的滑动改变处理事件 */
- (void)BR_addCustomScrollEventBlock:(void (^)(CGPoint, UIScrollView *))block {
    
    self.customEventChangeBlcok = block;
}

/*FIXME:  设置背景颜色 navBar */
- (void)BR_setNavBarBackgroundColor:(UIColor *)bgColor {
    
    self.br_navBarBgColor = bgColor;
    
}

/*FIXME: 透明度变化 */
- (void)br_scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    if (self.customEventChangeBlcok) {
        self.customEventChangeBlcok(scrollView.contentOffset,scrollView);
    }
    else {
        CGFloat NAVBAR_CHANGE_POINT = scrollView.br_headerViewHeight;
        UIColor * color = self.br_navBarBgColor;
        CGFloat offsetY = scrollView.contentOffset.y ;
        CGFloat alpha = 0;
        
        CGFloat topOffset = kBR_NavHeight-NAVBAR_CHANGE_POINT;
        if (self.br_strechType == BRStretchHeaderStrechType_NotStretchBegainScollNavAlpha) {
            
            alpha = MIN(1, (offsetY + NAVBAR_CHANGE_POINT)/(fabs(NAVBAR_CHANGE_POINT)));
            if ( alpha > 0 && alpha < 1.0) {
                self.navBarStatus =kBRViewControllerStretchHeaderViewNavBarStatus_WillShow;
            }
            else{
                self.navBarStatus = kBRViewControllerStretchHeaderViewNavBarStatus_DidShow;
            }
            [self.br_navBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];

        }
        else {
            if (offsetY > topOffset ) {
                
                alpha = MIN(1, (offsetY + (NAVBAR_CHANGE_POINT - kBR_NavHeight))/NAVBAR_CHANGE_POINT);
                if ( alpha > 0 && alpha < 1.0) {
                    self.navBarStatus =kBRViewControllerStretchHeaderViewNavBarStatus_WillShow;
                }
                else{
                    self.navBarStatus = kBRViewControllerStretchHeaderViewNavBarStatus_DidShow;
                }
                [self.br_navBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
                
            } else {
                
                [self.br_navBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
                self.navBarStatus = kBRViewControllerStretchHeaderViewNavBarStatus_NotShow;
            }
        
        }
        if (self.alphaBlcok) {
            self.alphaBlcok(self.navBarStatus,alpha);
        }
    }
}


#pragma mark ----- setter

- (UINavigationBar *)br_navBar {
    return  objc_getAssociatedObject(self, &kBRCustomNavBar);

}
- (void)setBr_navBar:(UINavigationBar *)br_navBar {
    objc_setAssociatedObject(self,&kBRCustomNavBar, br_navBar, OBJC_ASSOCIATION_RETAIN);

}

- (UINavigationItem *)br_navigationItem {
    return  objc_getAssociatedObject(self, &kBRCustomNavigationItem);

}

- (void)setBr_navigationItem:(UINavigationItem *)br_navigationItem {
    objc_setAssociatedObject(self,&kBRCustomNavigationItem, br_navigationItem, OBJC_ASSOCIATION_RETAIN);

}

- (void)setNavBarStatus:(kBRViewControllerStretchHeaderViewNavBarStatus)navBarStatus {
    objc_setAssociatedObject(self,&kBRCustomNavigationStatusKey, @(navBarStatus), OBJC_ASSOCIATION_ASSIGN);

}

- (kBRViewControllerStretchHeaderViewNavBarStatus)navBarStatus {
    NSNumber *number = objc_getAssociatedObject(self, &kBRCustomNavigationStatusKey);
    return number.integerValue;
    
}


- (void (^)(kBRViewControllerStretchHeaderViewNavBarStatus, CGFloat))alphaBlcok {
    
    return objc_getAssociatedObject(self, &kBRCustomNavigationChangedBlcokKey);
}

- (void)setAlphaBlcok:(void (^)(kBRViewControllerStretchHeaderViewNavBarStatus, CGFloat))alphaBlcok {
    
    objc_setAssociatedObject(self,&kBRCustomNavigationChangedBlcokKey, alphaBlcok, OBJC_ASSOCIATION_COPY);
}

- (void (^)(CGPoint, UIScrollView *))customEventChangeBlcok {
    return objc_getAssociatedObject(self, &kBRCustomNavigationCustomChangedKey);

}
- (void)setCustomEventChangeBlcok:(void (^)(CGPoint, UIScrollView *))customEventChangeBlcok {
    objc_setAssociatedObject(self,&kBRCustomNavigationCustomChangedKey, customEventChangeBlcok, OBJC_ASSOCIATION_COPY);

}

- (UIColor *)br_navBarBgColor {
    return objc_getAssociatedObject(self, &kBRCustomNavigationBgColorKey);
    
}
- (void)setBr_navBarBgColor:(UIColor *)br_navBarBgColor {
    objc_setAssociatedObject(self,&kBRCustomNavigationBgColorKey, br_navBarBgColor, OBJC_ASSOCIATION_RETAIN);

}

-(BRStretchHeaderStrechType)br_strechType {
    
    NSNumber *number = objc_getAssociatedObject(self, &kBRCustomNavigationStrechAutoFitFrameKey);
    return  number.boolValue;
    
}
-(void)setBr_strechType:(BRStretchHeaderStrechType)br_strechType {
    objc_setAssociatedObject(self,&kBRCustomNavigationStrechAutoFitFrameKey, @(br_strechType), OBJC_ASSOCIATION_ASSIGN);
    
}




@end
