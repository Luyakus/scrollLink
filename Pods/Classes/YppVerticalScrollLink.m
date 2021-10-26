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
@property (nonatomic, assign) CGPoint parentAnchor;
@end

@implementation YppVerticalScrollLink

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    if (self = [super initWithScrollView:scrollView]) {
        self.lastContentOffset = CGPointZero;
        self.parentAnchor = CGPointZero;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.parent) { // 子组件处理
        [self detectDirection]; // 动态更新滑动方向
        if (!self.drivenByCode) {
            if (self.direction == YppScrollDirectionBackward) {
                if (CGPointEqualToPoint(self.parentAnchor, CGPointZero)) {
                    self.parentAnchor = self.parent.scrollView.contentOffset; // 记录父组件的偏移量
                }
                if (!self.arriveHeader) {
                    self.parent.scrollView.contentOffset = self.parentAnchor;
                } else {
                    self.parentAnchor = CGPointZero;
                }
            }
        }
        self.hasCallScrollDidScroll = YES;
        self.lastContentOffset = scrollView.contentOffset;
    }
    if (self.currentChild) { // 父容器处理
        [self detectDirection]; // 动态更新滑动方向
        if (!self.drivenByCode) {
            if (self.direction == YppScrollDirectionForward) { // 向上滑动
                if (!self.arriveTail) { // 没到底
                    self.currentChild.scrollView.contentOffset = CGPointMake(self.currentChild.scrollView.contentOffset.x, 0); // 固定子组件偏移量
                }
            }
            if (self.direction == YppScrollDirectionBackward) {
                if (self.currentChild.arriveHeader) {
                    self.currentChild.scrollView.contentOffset = CGPointMake(self.currentChild.scrollView.contentOffset.x, 0);
                }
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
    self.drivenByCode = NO;
    CGPoint velocity = [gesture velocityInView:self.scrollView];
    if (velocity.y < 0) {
        self.direction = YppScrollDirectionForward;
    } else if (velocity.y > 0) {
        self.direction = YppScrollDirectionBackward;
    } else {
        self.direction = YppScrollDirectionStop;
    }
}

- (void)calculateDirection {
    if (self.scrollView.contentOffset.y - self.lastContentOffset.y > 0) {
        self.direction = YppScrollDirectionForward;
    } else if (self.scrollView.contentOffset.y - self.lastContentOffset.y < 0) {
        self.direction = YppScrollDirectionBackward;
    } else {
        self.direction = YppScrollDirectionStop;
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
