//
//  UIScrollView+Link.m
//  Neo
//
//  Created by DZ0400843 on 2021/9/23.
//
#import "YppLinkScrollView.h"
#import "YppLinkTableView.h"
#import "YppLinkCollectionView.h"

#import "UIScrollView+Link.h"

@implementation UIScrollView (Link)

- (YppScrollLink *)slink {
    if ([self.class isKindOfClass:YppLinkTableView.class] ||
        [self.class isKindOfClass:YppLinkCollectionView.class] ||
        [self.class isKindOfClass:YppLinkScrollView.class]) {
        return [(YppLinkScrollView *)self link];
    }
    return nil;
}

@end
