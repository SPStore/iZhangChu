//
//  ZCPlayImageView.h
//  iZhangChu
//
//  Created by Shengping on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//  中间含有播放按钮的imageView

#import <UIKit/UIKit.h>
#import "ZCRecommendWidgetItem.h"

typedef NS_ENUM(NSInteger, ZCPlayImageViewPlayButtonPosition) {
    ZCPlayImageViewPlayButtonPositionCenter,
    ZCPlayImageViewPlayButtonPositionRightBottom
};

typedef void(^TapBlock)(UITapGestureRecognizer *tap);
typedef void(^PlayBlock)(UIButton *button);


@interface ZCPlayImageView : UIImageView

@property (nonatomic, assign) ZCPlayImageViewPlayButtonPosition playButtonPosition;

@property (nonatomic, strong) ZCRecommendWidgetItem *imageItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *videoItem;

@property (nonatomic, copy) NSString *videoUrlString;
@property (nonatomic, copy) NSString *title;

@end
