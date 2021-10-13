//
//  UIScrollView+Link.h
//  Neo
//
//  Created by DZ0400843 on 2021/9/23.
//
#import "YppVerticalScrollLink.h"
#import "YppHorizontalScrollLink.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Link)
@property (nonatomic, readonly) YppScrollLink *slink;

@end

NS_ASSUME_NONNULL_END
