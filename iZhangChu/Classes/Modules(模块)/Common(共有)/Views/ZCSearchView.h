//
//  ZCSearchView.h
//  iZhangChu
//
//  Created by Libo on 17/4/29.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZCSearchViewDelegate <NSObject>

@optional;
- (void)searchViewCancelButtonClicked;

- (void)searchViewTextFieldDidChanged:(UITextField *)textField;

- (void)searchViewTextFieldidBeginEditing:(UITextField *)textField;

- (void)searchViewKeyboardSearchButtonClicked:(NSString *)string;

- (BOOL)searchViewTextfield:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

@interface ZCSearchView : UIView

+ (instancetype)searchView;

@property (weak, nonatomic, readonly) IBOutlet UITextField *textField;

@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, weak) id<ZCSearchViewDelegate> delegate;


@end
