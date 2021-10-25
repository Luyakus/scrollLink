//
//  YppVerticalScrollLink.m
//  Neo
//
//  Created by DZ0400843 on 2021/9/23.
//
#import "UIScrollView+Link.h"
#import "YppScrollLink+Private.h"
#import "YppVerticalScrollLink.h"

@interface YppVerticalScrollLink()
@property (nonatomic, assign) BOOL gestureLinkFail; // 手势联动失效

@end

@implementation YppVerticalScrollLink

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    if (self = [super initWithScrollView:scrollView]) {
        id <UIScrollViewDelegate> delegate = scrollView.delegate;
        scrollView.delegate = nil; // 防止递归
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + 0.5); // 防止第一次下拉刷新失效
        scrollView.delegate = delegate;
        self.lastContentOffset = CGPointZero;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.parent) { // 子组件处理
        [self detectDirection]; // 动态更新滑动方向
        if (self.parent.direction == YppScrollDirectionBackward && // 下拉刷新会有回弹, 所以用父容器方向判断
            self.arriveHeader && // 子组件到顶
            !self.parent.arriveHeader) { //  父容器没到顶
            if (self.scrollView.panGestureRecognizer.state == UIGestureRecognizerStatePossible) { // 手指停止拖拽, 惯性动画
                // 惯性处理
                [UIView animateWithDuration:0.4
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                    self.parent.scrollView.contentOffset = CGPointMake(self.parent.scrollView.contentOffset.x, 0);
                } completion:^(BOOL finished) {
                }];
            } else if (self.gestureLinkFail) {
                // 手势联动失效处理
                [UIView animateWithDuration:1
                                      delay:0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                    self.parent.scrollView.contentOffset = CGPointMake(self.parent.scrollView.contentOffset.x, 0);
                } completion:^(BOOL finished) {
                }];
            }
            
        }
        self.hasCallScrollDidScroll = YES;
        self.lastContentOffset = scrollView.contentOffset;
    }
    if (self.currentChild) { // 父容器处理
        [self detectDirection]; // 动态更新滑动方向
        if (self.direction == YppScrollDirectionForward) { // 向上滑动
            if (!self.arriveTail) { // 没到底
                self.currentChild.scrollView.contentOffset = CGPointMake(0, 1); // 固定子组件偏移量
            } else {
                
            }
        }
        if (self.direction == YppScrollDirectionBackward) {
            if (self.currentChild.arriveHeader) {
                self.currentChild.scrollView.contentOffset = CGPointMake(0, 1);
            }
        }
        self.hasCallScrollDidScroll = YES;
        self.lastContentOffset = scrollView.contentOffset;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:UIPanGestureRecognizer.class] && // 判断是不是滑动手势
        [otherGestureRecognizer isKindOfClass:UIPanGestureRecognizer.class]) { // 判断是不是滑动手势
        if (gestureRecognizer.delegate == (id<UIGestureRecognizerDelegate>)self.scrollView) { // 判断是不是自己 scrollView 上的滑动手势
            [self detectGestureDirection:(UIPanGestureRecognizer *)gestureRecognizer];
            BOOL shouldRecognizeSimulty = self.scrollView.link.parent.scrollView == otherGestureRecognizer.view;
            if (shouldRecognizeSimulty) {
                if (self.parent) {
                    self.parent.currentChild = self; // 动态更新 child
                    // 向下滚动, 子组件没到顶
                    if (self.direction == YppScrollDirectionBackward && !self.arriveHeader) {
                        shouldRecognizeSimulty = NO;
                    }
                    self.gestureLinkFail = !shouldRecognizeSimulty;
                }
            }
            return shouldRecognizeSimulty;
        }
    }
    return NO;
}


#pragma mark - helper
- (void)detectDirection {
    if (self.hasCallScrollDidScroll) { // 第一使用手势方向
        [self calculateDirection]; // 接线来使用计算方向
    }
}

- (void)detectGestureDirection:(UIPanGestureRecognizer *)gesture {
    self.hasCallScrollDidScroll = NO;
    CGPoint velocity = [gesture velocityInView:self.scrollView];
    if (velocity.y < 0) {
        self.direction = YppScrollDirectionForward;
    } else {
        self.direction = YppScrollDirectionBackward;
    }
}

- (void)calculateDirection {
    if (self.scrollView.contentOffset.y - self.lastContentOffset.y > 0) {
        self.direction = YppScrollDirectionForward;
    } else if (self.scrollView.contentOffset.y - self.lastContentOffset.y < 0) {
        self.direction = YppScrollDirectionBackward;
    }
}

- (BOOL)arriveTail {
    CGFloat maxY = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
    BOOL result = self.scrollView.contentOffset.y >= maxY - 2;
    return result;
}

- (BOOL)arriveHeader {
    BOOL result = self.scrollView.contentOffset.y <= 2;
    return result;
}


@end
