//
//  YppLinkTableView.m
//  YPPCommunity
//
//  Created by DZ0400843 on 2021/10/13.
//
#import "YppScrollLink+Private.h"
#import "YppLinkTableView.h"

@implementation YppLinkTableView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (self.link) {
        return [self.link gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return NO;
}

@end
