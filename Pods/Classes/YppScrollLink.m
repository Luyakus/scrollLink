//
//  LGScrollLink.m
//  Neo
//
//  Created by DZ0400843 on 2021/9/22.
//

#import "YppScrollLink+Private.h"
#import "UIScrollView+Link.h"
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


@end
