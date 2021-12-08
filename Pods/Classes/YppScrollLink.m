//
//  LGScrollLink.m
//  Neo
//
//  Created by DZ0400843 on 2021/9/22.
//

#import "YppScrollLink+Private.h"
#import "UIScrollView+Link.h"
#import "YppVerticalScrollLink.h"
#import "YppHorizontalScrollLink.h"
#import "YppScrollLink.h"

@interface YppScrollLink() <UIGestureRecognizerDelegate>

@end

@implementation YppScrollLink

- (instancetype)initWithScrollView:(UIScrollView *)scrollView {
    if (self = [super init]) {
        self.scrollView = scrollView;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return NO;
}

- (void)detectParent {
    UIView *superView = self.scrollView.superview;
    while (superView) {
        if ([superView isKindOfClass:UIScrollView.class]) {
            YppScrollLink *link = [(UIScrollView *)superView link];
            if (link) {
                if (([link isKindOfClass:YppVerticalScrollLink.class] && [self isKindOfClass:YppVerticalScrollLink.class]) ||
                    ([link isKindOfClass:YppHorizontalScrollLink.class] && [self isKindOfClass:YppHorizontalScrollLink.class])) {
                    self.parent = link;
                    break;
                } else {
                    superView = superView.superview;
                    continue;
                }
            } else {
                superView = superView.superview;
                continue;
            }
        } else {
            superView = superView.superview;
            continue;
        }
    }
}

@end
