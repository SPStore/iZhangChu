//
//  ZCBasicViewController.h
//  掌厨
//
//  Created by Libo on 17/4/17.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCMacro.h"
#import "ZCNavigationView.h"

@interface ZCBasicViewController : UIViewController {
    ZCNavigationView *_navigationView;
}

@property (nonatomic, strong) ZCNavigationView  *navigationView; // 自定义的nagationBar


@end
