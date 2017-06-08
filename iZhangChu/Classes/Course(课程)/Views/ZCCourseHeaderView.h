//
//  ZCCourseHeaderView.h
//  iZhangChu
//
//  Created by Shengping on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//  课程控制器的头部

#import <UIKit/UIKit.h>
#import "ZCCourseRelateModel.h"
#import "ZCCourseZanModel.h"
@class ZCCourseHeaderModel;
@class ZCCourseEpisodeButton;
@class ZCCourseEpisodeModel;
@class SPButton;


@protocol ZCCourseHeaderViewDelegate <NSObject>

- (void)headerViewEpisodeButtonClicked:(ZCCourseEpisodeButton *)episodeButton;

- (void)headerViewUpdateFoldingButtonClicked:(SPButton *)sender;

@end

@interface ZCCourseHeaderView : UIView

+ (instancetype)courseHeaderView;

@property (nonatomic, strong) ZCCourseHeaderModel *headerModel;
@property (nonatomic, strong) ZCCourseRelateModel *courseRelateModel;
@property (nonatomic, strong) ZCCourseZanModel *zanModel;
@property (nonatomic, assign) NSInteger commentCount;

@property (nonatomic, weak) id<ZCCourseHeaderViewDelegate> delegate;

@end



#pragma mark 其他类

@interface ZCCourseEpisodeButton : UIButton
@property (nonatomic, strong) ZCCourseEpisodeModel *episodeModel;
@end

@interface ZCCourseDishesView : UIView
@property (nonatomic, strong) ZCCourseDishesModel *dish;
@end


@interface ZCCourseZanUserButton: UIButton
@property (nonatomic, strong) ZCCourseZanUser *zanUser;
@end




