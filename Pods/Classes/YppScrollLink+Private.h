//
//  LGScrollLink+LGScrollLink_Private.h
//  Neo
//
//  Created by DZ0400843 on 2021/9/28.
//

#import "YppScrollLink.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, YppScrollDirection) {
    YppScrollDirectionStop, // stop 状态并不准确, 请不要使用
    YppScrollDirectionForward, // 竖向时向上, 横向时向左
    YppScrollDirectionBackward, // 竖向时向下, 横向时向右
};

@interface YppScrollLink ()
// helper property
- (void)detectParent;
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign) YppScrollDirection direction;
@property (nonatomic, readonly) BOOL arriveHeader;
@property (nonatomic, readonly) BOOL arriveTail;

@property (nonatomic, assign) BOOL hasCallScrollDidScroll;
@property (nonatomic, assign) CGPoint lastContentOffset;

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)link_scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)addScrollDelegateMethodDynamic:(id<UIScrollViewDelegate>)linkDelegate;
@end

NS_ASSUME_NONNULL_END
