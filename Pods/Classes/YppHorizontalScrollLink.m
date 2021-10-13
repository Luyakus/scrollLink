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
    if (self.parent) {
        if (self.direction == LGScrollDirectionForward) {
            if (!self.arriveTail) {
                self.parent.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * self.hIndex, 0);
            } else {
                
            }
        }
        if (self.direction == LGScrollDirectionBackward) {
            if (!self.arriveHeader) {
                self.parent.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width * self.hIndex, 0);
            } else {
                if (!self.parent.arriveHeader) {
                    self.scrollView.contentOffset = CGPointMake(0, 0);
                } else {
                    
                }
            }
        }
    }
    self.lastContentOffset = scrollView.contentOffset;
}

- (LGScrollDirection)direction {
    if (CGPointEqualToPoint(CGPointZero, self.lastContentOffset)) {
        return LGScrollDirectionInit;
    } else if (ABS(self.lastContentOffset.x - self.scrollView.contentOffset.x) < 0.00001) {
        return LGScrollDirectionStop;
    } else if (self.scrollView.contentOffset.x - self.lastContentOffset.x > 0) {
        return LGScrollDirectionForward;
    } else if (self.scrollView.contentOffset.x - self.lastContentOffset.x < 0) {
        return LGScrollDirectionBackward;
    }  else {
        return LGScrollDirectionInit;
    }
}


- (BOOL)arriveTail {
    CGFloat maxX = self.scrollView.contentSize.width - self.scrollView.bounds.size.width;
    BOOL result = self.scrollView.contentOffset.x >= maxX - 0.5;
    return result;
}

- (BOOL)arriveHeader {
    BOOL result = self.scrollView.contentOffset.x < 0;
    return result;
}
@end

/*
 // 多级联动, 未完成
 - (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
     if ([gestureRecognizer isKindOfClass:UIPanGestureRecognizer.class] &&
         [otherGestureRecognizer isKindOfClass:UIPanGestureRecognizer.class]) {
         if ([otherGestureRecognizer.view isKindOfClass:UIScrollView.class]) {
             UIScrollView *otherSrollView = (UIScrollView *)otherGestureRecognizer.view;
             LGScrollLink *otherLink = otherSrollView.link;
             if ([self.class isEqual:otherLink.class]) {
                 return YES;
             }
         }
     }
     return NO;
 }
 */
