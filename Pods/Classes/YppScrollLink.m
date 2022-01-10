//
//  LGScrollLink.m
//  Neo
//
//  Created by DZ0400843 on 2021/9/22.
//
#import <objc/runtime.h>
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
        [self addScrollDelegateMethodDynamic:scrollView.delegate];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}
// 动态添加的方法
- (void)link_scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.link) {
        [scrollView.link scrollViewDidScroll:scrollView];
    }
    if (![self respondsToSelector:@selector(link_scrollViewDidScroll:)]) return;
    [self link_scrollViewDidScroll:scrollView];
}


- (void)addScrollDelegateMethodDynamic:(id<UIScrollViewDelegate>)linkDelegate {
    static NSMutableDictionary *cache = nil;
    if (!cache) {
        cache = @{}.mutableCopy;
    }
    if ([cache[NSStringFromClass([linkDelegate class])] boolValue]) {
        return;
    }
    cache[NSStringFromClass([linkDelegate class])] = @(1);
    SEL scrollSel = @selector(scrollViewDidScroll:);
    SEL linkScrollSel = @selector(link_scrollViewDidScroll:);
    Method originMethod = class_getInstanceMethod([linkDelegate class], scrollSel);
    Method currentMethod = class_getInstanceMethod([linkDelegate class], linkScrollSel);
    if (!originMethod) {
        originMethod = class_getInstanceMethod(self.class, scrollSel);
        BOOL isAddMethod = class_addMethod([linkDelegate class], scrollSel, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        if (isAddMethod) {
            NSLog(@"%@添加方法成功", @"scrollViewDidScroll");
        }
        originMethod = class_getInstanceMethod([linkDelegate class], scrollSel);
    }
    
    if (!currentMethod) {
        currentMethod = class_getInstanceMethod(self.class, linkScrollSel);
        BOOL isAddMethod = class_addMethod([linkDelegate class], linkScrollSel, method_getImplementation(currentMethod), method_getTypeEncoding(currentMethod));
        if (isAddMethod) {
            NSLog(@"%@添加方法成功", @"lg_scrollViewDidScroll");
        }
        currentMethod = class_getInstanceMethod([linkDelegate class], linkScrollSel);
    }
    method_exchangeImplementations(originMethod, currentMethod);
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
