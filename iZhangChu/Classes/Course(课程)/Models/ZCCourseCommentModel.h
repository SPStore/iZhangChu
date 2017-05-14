//
//  ZCCourseCommentModel.h
//  iZhangChu
//
//  Created by Shengping on 17/4/27.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCBasicModel.h"

@interface ZCCourseCommentModel : ZCBasicModel
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger size;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSArray *data;
@end


@interface ZCCourseComment : NSObject
@property (nonatomic, copy) NSString *head_img;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *id;
@property (nonatomic, assign) NSInteger istalent;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, copy) NSString *parent_id;
@property (nonatomic, copy) NSString *relate_id;
@property (nonatomic, strong) NSArray *parents;
@end
