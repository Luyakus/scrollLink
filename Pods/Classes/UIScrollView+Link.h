//
//  UIScrollView+Link.h
//  Neo
//
//  Created by DZ0400843 on 2021/9/23.
//
#import "YppScrollLink.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Link)
@property (nonatomic, weak) id <UIScrollViewDelegate> vLinkDelegate;
@property (nonatomic, weak) id <UIScrollViewDelegate> hLinkDelegate;

@property (nonatomic, strong) YppScrollLink *link;

@end

NS_ASSUME_NONNULL_END
