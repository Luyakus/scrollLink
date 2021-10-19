//
//  UIScrollView+Link.m
//  Neo
//
//  Created by DZ0400843 on 2021/9/23.
//

#import <objc/runtime.h>
#import "YppScrollLink+Private.h"
#import "UIScrollView+Link.h"

@implementation UIScrollView (Link)
static NSInteger linkKey = 0;

- (void)setLink:(YppScrollLink *)link {
    objc_setAssociatedObject(self, &linkKey, link, OBJC_ASSOCIATION_RETAIN);
}

- (YppScrollLink *)link {
    return objc_getAssociatedObject(self, &linkKey);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.link) {
        return [self.link gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return NO;
}

@end
