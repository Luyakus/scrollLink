//
//  LGScrollLink.h
//  Neo
//
//  Created by DZ0400843 on 2021/9/22.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSUInteger, YppScrollDirection) {
    YppScrollDirectionForward, // 竖向时向上, 横向时向左
    YppScrollDirectionBackward, // 竖向时向下, 横向时向右
};

@interface YppScrollLink : NSObject

@property (nonatomic, weak) YppScrollLink *parent;
@property (nonatomic, weak) YppScrollLink *currentChild;

@property (nonatomic, assign) YppScrollDirection direction;
@property (nonatomic, readonly) BOOL arriveHeader;
@property (nonatomic, readonly) BOOL arriveTail;

// 横向联动时设置
@property (nonatomic, assign) NSInteger hIndex;



- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
