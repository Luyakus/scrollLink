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
    YppScrollDirectionStop, // stop 状态并不准确, 请不要使用
    YppScrollDirectionForward, // 竖向时向上, 横向时向左
    YppScrollDirectionBackward, // 竖向时向下, 横向时向右
};

@interface YppScrollLink : NSObject
@property (nonatomic, assign) BOOL drivenByCode; // 如果代码更新 contentOffset 设置为YES;

@property (nonatomic, weak) YppScrollLink *parent;
@property (nonatomic, weak) YppScrollLink *currentChild; // 只有手势驱动时会自动更新, 其他情况下请自行更新

@property (nonatomic, assign) YppScrollDirection direction;
@property (nonatomic, readonly) BOOL arriveHeader;
@property (nonatomic, readonly) BOOL arriveTail;

// 横向联动时设置
@property (nonatomic, assign) NSInteger hIndex;


// 一定要在 scorllview 的 scrollViewDidScroll 代理方法里第一行调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END

