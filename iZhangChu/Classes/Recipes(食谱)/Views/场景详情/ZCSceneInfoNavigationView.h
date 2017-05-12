//
//  ZCSceneInfoNavigationView.h
//  iZhangChu
//
//  Created by Libo on 17/5/12.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ClickedBackButtonBlock)();
typedef void(^ClickedShareButtonBlock)();
typedef void(^ClickedSearchButtonBlock)();


@interface ZCSceneInfoNavigationView : UIView

+ (instancetype)shareSceneInfoNavigationView;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *realBackButton;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) ClickedBackButtonBlock clickedBackButtonBlock;

@property (nonatomic, copy) ClickedShareButtonBlock clickedShareButtonBlock;

@property (nonatomic, copy) ClickedSearchButtonBlock clickedSearchButtonBlock;


@end
