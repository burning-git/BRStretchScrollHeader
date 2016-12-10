# BRStretchScrollHeader
    一款 顶部视图跟随 滑动的变化而变化 视图工具

## 使用场景
    * tablew + 顶部 view，     希望tablew 滑动时，顶部视图，放大缩放效果
    * tablew + nav，           希望tablew滑动，nav 渐变效果
    * tablew + 顶部 view+ nav，希望tablew 滑动时，顶部视图，放大缩放效果,以及 nav 渐变效果

### 使用方式 

    **tablew 的使用
    * 增加 stretchHeaderView （ps ，如果有偏移量是 64的话 ,请设置  viewController.automaticallyAdjustsScrollViewInsets = NO;）
    - (void)BR_addStrechHeaderView:(UIView *)headerView;
    * 增加 offset 变化block
    - (void)BR_addContentOffsetBlcok:(void(^)(CGPoint point,UIScrollView *view))block;

    **ViewController 的使用
    * 设置背景颜色 navBar
    - (void)BR_setNavBarBackgroundColor:(UIColor *)bgColor;
    * viewController 增加 BRStretchHeaderView
    - (void)BR_addVCStrechHeaderView:(UIView *)headerView InTablewView:(UITableView *)tablew;
    * 导航栏透明度变化 blcok
    - (void)BR_addVCNavBarStatusChangedBlcok:(void(^)(kBRViewControllerStretchHeaderViewNavBarStatus staus, CGFloat alpha))blcok;
    * 自定义滑动变化导航栏透明事件, 覆盖自带的滑动改变处理事件
    - (void)BR_addCustomScrollEventBlock:(void(^)(CGPoint point,UIScrollView *scrollView))block;


    ** pod 引入 (如果没有搜索到 还未上传, ![试试](http://blog.cocoachina.com/article/29127))
    pod 'BRStretchHeader', '~> 0.1.0'

### 其他
    项目中使用 
    pod 'LTNavigationBar', '~> 2.1.6'  (决绝了 导航栏自定义颜色)
    pod 'FDFullscreenPopGesture', '~> 1.1' (决绝了，隐藏导航栏，不导致全局都隐藏)  
    感谢🙏该对应的作者！！！！

### 效果

   ![图片加载](BRStretchScrollHeader/Resources/StretchScollHeader.gif)
