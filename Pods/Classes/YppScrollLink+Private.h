//
//  LGScrollLink+LGScrollLink_Private.h
//  Neo
//
//  Created by DZ0400843 on 2021/9/28.
//

#import "YppScrollLink.h"

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, LGScrollDirection) {
    LGScrollDirectionInit,
    LGScrollDirectionStop,
    LGScrollDirectionForward,
    LGScrollDirectionBackward,
};

@interface YppScrollLink ()

// helper property
@property (nonatomic, assign) CGPoint lastContentOffset;

@property (nonatomic, assign) LGScrollDirection direction;
@property (nonatomic, readonly) BOOL arriveHeader;
@property (nonatomic, readonly) BOOL arriveTail;

@property (nonatomic, weak) UIScrollView *scrollView;

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
@end

NS_ASSUME_NONNULL_END
