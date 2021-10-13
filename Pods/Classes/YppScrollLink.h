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
// 横向联动时设置
@property (nonatomic, assign) NSInteger hIndex;
@property (nonatomic, weak) YppScrollLink *parent;

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
