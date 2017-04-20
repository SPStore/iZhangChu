//
//  SPButton.h
//  WeChat
//
//  Created by leshengping on 16/10/28.
//  Copyright © 2016年 leshengping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QYRecommendTab;
@class QYRecommendCityFunctionItem;
@interface SPButton : UIButton

- (instancetype)initWithImageRatio:(CGFloat)ratio;

@property (nonatomic, assign) CGFloat ratio;



@end
