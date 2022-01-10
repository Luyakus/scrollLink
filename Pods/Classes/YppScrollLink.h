//
//  LGScrollLink.h
//  Neo
//
//  Created by DZ0400843 on 2021/9/22.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YppScrollLink : NSObject
@property (nonatomic, assign) BOOL drivenByCode; // 如果代码更新 contentOffset 设置为YES;

@property (nonatomic, weak) YppScrollLink *parent;
@property (nonatomic, weak) YppScrollLink *currentChild; // 只有手势驱动时会自动更新, 其他情况下请自行更新

//- (void)linkScrollView:(UIScrollView *)scrollView;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END

