//
//  BREnumHeader.h
//  BRStretchScrollHeader
//
//  Created by gitBurning on 17/2/27.
//  Copyright © 2017年 BR. All rights reserved.
//

#ifndef BREnumHeader_h
#define BREnumHeader_h

/**
 strech 类型
 
 - BRStretchHeaderStrechType_Default:    header 拉伸，滑动到header height 变化
 - BRStretchHeaderStrechType_NotStretchBegainScollNavAlpha: header 不拉伸，nav 一滑动就alpha 变化
 - BRStretchHeaderStrechType_NotStretchScollHeaderNavAlpha:  header 不拉伸，nav 滑动到header height才 变化
 */
typedef NS_ENUM(NSUInteger, BRStretchHeaderStrechType) {
    BRStretchHeaderStrechType_Default = 0,
    BRStretchHeaderStrechType_NotStretchBegainScollNavAlpha,
    BRStretchHeaderStrechType_NotStretchScollHeaderNavAlpha,
};
#endif /* BREnumHeader_h */
