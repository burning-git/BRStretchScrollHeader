//
//  UIScrollView+BRStretchHeaderView.m
//  BRTablewStretchHeader
//
//  Created by gitBurning on 16/12/8.
//  Copyright © 2016年 BR. All rights reserved.
//

#import "UIScrollView+BRStretchHeaderView.h"
#import <objc/runtime.h>

static NSString *const kBRcontentOffsetY = @"contentOffset";

static NSString *kBRTabelewBeforeFrame = @"kBRTabelewBeforeFramekasldjaklsdjalksdjasd";
static NSString *kBRTabelewHeaderViewHeightKey = @"kBRTabelewHeaderViewHeightKey";
static NSString *kBRTabelewHeaderContentOffsetArrayKey = @"kBRTabelewHeaderContentOffsetArrayKey";

static NSString *kBRTabelewHeaderStrechAutoFitFrameKey = @"kBRTabelewHeaderStrechAutoFitFrameKey";

@interface UIScrollView()
@property (nonatomic, assign) CGRect beforeFrame;
@property (nonatomic, strong) NSMutableArray *blocksArray;
@end

@implementation UIScrollView (BRStretchHeaderView)


+(void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSString *deallocString = @"dealloc";
        SEL sel = NSSelectorFromString(deallocString);
        Method fromMethod = class_getInstanceMethod([self class], sel);
        Method toMethod = class_getInstanceMethod([self class], @selector(br_dealloc));

        method_exchangeImplementations(fromMethod, toMethod);

    });
    
}
- (void)br_dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
  
    @try {
        
        [self removeObserver:self forKeyPath:kBRcontentOffsetY];

    } @catch (NSException *exception) {
        
    } @finally {
        
    }

}



- (void)BR_addStrechHeaderView:(UIView *)headerView {
    
    
    CGRect frame = headerView.frame;
    frame.origin.y = -frame.size.height + frame.origin.y;
    headerView.frame = frame;
    self.beforeFrame = frame;
    self.contentInset = UIEdgeInsetsMake(frame.size.height, 0, 0, 0);
    [self setContentOffset:CGPointMake(self.contentOffset.x, -self.contentInset.top)];
    headerView.tag = 1000;
    [self addSubview:headerView];
    
    //这里延迟，因为 调用 setContentOffset 会 引起 kBRcontentOffsetY 的变化。
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [self addObserver:self forKeyPath:kBRcontentOffsetY options:NSKeyValueObservingOptionNew context:nil];
        
    });
    
    self.br_headerViewHeight = frame.size.height;
    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary*)change context:(void *)context {
    
    if ([keyPath isEqualToString:kBRcontentOffsetY] ) {
        
        [self br_scrollViewDidScroll:self];
        
    }
    
}

- (void)br_scrollViewDidScroll:(UIScrollView*)scrollView {
    
    CGFloat yOffset  = scrollView.contentOffset.y;
    yOffset += self.contentInset.top;//因为偏移了 header的高度
    
    UIView *headerView = [scrollView viewWithTag:1000];
    if (yOffset <= 0  && self.br_strechType == BRStretchHeaderStrechType_Default) {
        
        CGRect newFrame = CGRectMake(yOffset, self.beforeFrame.origin.y + yOffset , self.beforeFrame.size.width + fabs(yOffset)*2, self.beforeFrame.size.height + fabs(yOffset));

        headerView.frame = newFrame;
        
    }
    if (self.blocksArray.count > 0) {
        
        [self.blocksArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            void(^blcok)(CGPoint point,UIScrollView *scrol) = obj;
            if (blcok) {
                blcok(scrollView.contentOffset,scrollView);
            }
        }];
    }
    
}


#pragma mark --- interface
- (void)BR_addContentOffsetBlcok:(void (^)(CGPoint, UIScrollView *))block {
    
    if (!self.blocksArray) {
        self.blocksArray = [NSMutableArray arrayWithCapacity:0];
    }
    if (![self.blocksArray containsObject:block]) {
        [self.blocksArray addObject:block];
    }
}

#pragma mark --- setter

- (void)setBlocksArray:(NSMutableArray *)blocksArray {
    
    objc_setAssociatedObject(self,&kBRTabelewHeaderContentOffsetArrayKey, blocksArray, OBJC_ASSOCIATION_RETAIN);
    
}

- (NSMutableArray *)blocksArray {
    
    return objc_getAssociatedObject(self, &kBRTabelewHeaderContentOffsetArrayKey);
}

- (CGFloat)br_headerViewHeight {
    
    NSNumber *number = objc_getAssociatedObject(self, &kBRTabelewHeaderViewHeightKey);
    return number.floatValue;
}

- (void)setBr_headerViewHeight:(CGFloat)br_headerViewHeight {
    objc_setAssociatedObject(self,&kBRTabelewHeaderViewHeightKey, @(br_headerViewHeight), OBJC_ASSOCIATION_ASSIGN);

}

- (CGRect)beforeFrame {
    
    NSValue *valyes = objc_getAssociatedObject(self, &kBRTabelewBeforeFrame);
    return [valyes CGRectValue];
    
}

- (void)setBeforeFrame:(CGRect)beforeFrame {
    objc_setAssociatedObject(self,&kBRTabelewBeforeFrame, [NSValue valueWithCGRect:beforeFrame], OBJC_ASSOCIATION_RETAIN);
    
}

-(BRStretchHeaderStrechType)br_strechType {
    
    NSNumber *number = objc_getAssociatedObject(self, &kBRTabelewHeaderStrechAutoFitFrameKey);
    return  number.boolValue;
    
}
-(void)setBr_strechType:(BRStretchHeaderStrechType)br_strechType {
    objc_setAssociatedObject(self,&kBRTabelewHeaderStrechAutoFitFrameKey, @(br_strechType), OBJC_ASSOCIATION_ASSIGN);
    
}



@end
