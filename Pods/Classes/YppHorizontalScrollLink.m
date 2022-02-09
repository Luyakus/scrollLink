//
//  LGHorizontalScrollLink.m
//  Neo
//
//  Created by DZ0400843 on 2021/9/23.
//
#import "UIScrollView+Link.h"
#import "YppScrollLink+Private.h"
#import "YppHorizontalScrollLink.h"

@interface YppHorizontalScrollLink()

@end

@implementation YppHorizontalScrollLink

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    if (self = [super initWithScrollView:scrollView]) {
        self.lastContentOffset = CGPointZero;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 横滑联动都是一下一下的所以不需要控制偏移量, 使用手势就可以
    [self detectDirection];
    self.hasCallScrollDidScroll = YES;
    self.lastContentOffset = scrollView.contentOffset;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:UIPanGestureRecognizer.class] && // 判断是不是滑动手势
        [otherGestureRecognizer isKindOfClass:UIPanGestureRecognizer.class]) { // 判断是不是滑动手势
        if (gestureRecognizer.delegate == (id<UIGestureRecognizerDelegate>)self.scrollView) { // 判断是不是自己 scrollView 上的滑动手势
            if (!self.currentChild && !self.parent) {
                [self detectParent];
            }
            [self detectGestureDirection:(UIPanGestureRecognizer *)gestureRecognizer];
            BOOL shouldRecognizeSimulty = self.scrollView.link.parent.scrollView == otherGestureRecognizer.view;
            if (shouldRecognizeSimulty && self.parent) {
                self.parent.currentChild = self;
                if ((self.parent.direction == YppScrollDirectionForward && self.arriveTail) || (self.parent.direction == YppScrollDirectionBackward && self.arriveHeader)) {
                    // 往左划, 子组件到底, 联动
                    // 往右划, 子组件到头, 联动
                } else {
                    shouldRecognizeSimulty = NO;
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
    self.drivenByCode = NO;
    self.hasCallScrollDidScroll = NO;
    CGPoint velocity = [gesture velocityInView:self.scrollView];
    if (velocity.x < 0) {
        self.direction = YppScrollDirectionForward;
    } else if (velocity.x > 0) {
        self.direction = YppScrollDirectionBackward;
    } else {
        self.direction = YppScrollDirectionStop;
    }
}

- (void)calculateDirection {
    if (self.scrollView.contentOffset.x - self.lastContentOffset.x > 0) {
        self.direction = YppScrollDirectionForward;
    } else if (self.scrollView.contentOffset.x - self.lastContentOffset.x < 0) {
        self.direction = YppScrollDirectionBackward;
    } else {
        self.direction = YppScrollDirectionStop;
    }
}


- (BOOL)arriveTail {
    CGFloat maxX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
    BOOL result = self.scrollView.contentOffset.x >= maxX - 0.5;
    return result;
}

- (BOOL)arriveHeader {
    BOOL result = self.scrollView.contentOffset.x <= 2;
    return result;
}

@end
