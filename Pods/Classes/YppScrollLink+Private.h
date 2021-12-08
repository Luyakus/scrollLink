//
//  LGScrollLink+LGScrollLink_Private.h
//  Neo
//
//  Created by DZ0400843 on 2021/9/28.
//

#import "YppScrollLink.h"

NS_ASSUME_NONNULL_BEGIN



@interface YppScrollLink ()
@property (nonatomic, assign) BOOL hasCallScrollDidScroll;
@property (nonatomic, assign) CGPoint lastContentOffset;
// helper property

- (void)detectParent;
@property (nonatomic, weak) UIScrollView *scrollView;

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
@end

NS_ASSUME_NONNULL_END
