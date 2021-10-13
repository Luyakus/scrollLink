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
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.parent) {
        if (self.direction == LGScrollDirectionForward) {
            if (!self.parent.arriveTail) {
                self.scrollView.contentOffset = CGPointMake(0, 1);
            }
        }
        if (self.direction == LGScrollDirectionBackward) {
            if (CGPointEqualToPoint(self.parentAnchor, CGPointZero)) {
                self.parentAnchor = self.parent.scrollView.contentOffset;
            }
            if (!self.arriveHeader) {
                self.parent.scrollView.contentOffset = self.parentAnchor;
            } else {
                self.parentAnchor = CGPointZero;
                if (!self.parent.arriveHeader) {
                    self.scrollView.contentOffset = CGPointMake(0, 1);
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
    } else if (ABS(self.lastContentOffset.y - self.scrollView.contentOffset.y) < 0.00001) {
        return LGScrollDirectionStop;
    } else if (self.scrollView.contentOffset.y - self.lastContentOffset.y > 0) {
        return LGScrollDirectionForward;
    } else if (self.scrollView.contentOffset.y - self.lastContentOffset.y < 0) {
        return LGScrollDirectionBackward;
    }  else {
        return LGScrollDirectionInit;
    }
}

- (BOOL)arriveTail {
    CGFloat maxY = self.scrollView.contentSize.height - self.scrollView.bounds.size.height;
    BOOL result = self.scrollView.contentOffset.y >= maxY - 0.5;
    return result;
}

- (BOOL)arriveHeader {
    BOOL result = self.scrollView.contentOffset.y <= 5;
    return result;
}

@end
