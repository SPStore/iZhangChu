//
//  ZCPlayImageView.h
//  iZhangChu
//
//  Created by Libo on 17/4/21.
//  Copyright © 2017年 iDress. All rights reserved.
//  中间含有播放按钮的imageView

#import <UIKit/UIKit.h>
#import "ZCRecommendWidgetItem.h"

@interface ZCPlayImageView : UIImageView
@property (nonatomic, strong) ZCRecommendWidgetItem *imageItem;
@property (nonatomic, strong) ZCRecommendWidgetItem *videoItem;
@end
