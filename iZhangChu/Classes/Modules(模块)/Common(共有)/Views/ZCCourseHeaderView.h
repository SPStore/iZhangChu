//
//  ZCCourseHeaderView.h
//  iZhangChu
//
//  Created by Libo on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//  课程控制器的头部

#import <UIKit/UIKit.h>

@class ZCCourseHeaderModel;

@interface ZCCourseHeaderView : UIView

+ (instancetype)courseHeaderView;

@property (nonatomic, strong) ZCCourseHeaderModel *headerModel;

@end



@interface ZCCourseEpisodeButton : UIButton

@end
