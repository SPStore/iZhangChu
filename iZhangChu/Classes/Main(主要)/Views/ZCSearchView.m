//
//  ZCSearchView.m
//  iZhangChu
//
//  Created by Libo on 17/4/29.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCSearchView.h"

@interface ZCSearchView() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@end

@implementation ZCSearchView

+ (instancetype)searchView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].lastObject;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _textField.delegate = self;

    _textField.borderStyle = UITextBorderStyleRoundedRect;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 15)];
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 15, 15)];
    [leftView addSubview:leftImageView];
    leftImageView.image = [UIImage imageNamed:@"search1"];
    _textField.leftView = leftView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
    // KVC获取占位label
    UILabel *placeholderLabel = [_textField valueForKey:@"_placeholderLabel"];
    placeholderLabel.textColor = [UIColor blackColor];
    placeholderLabel.alpha = 0.4;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    
    // 一开始就让textField为编辑状态
    [_textField becomeFirstResponder];
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = [placeholder copy];
     // 通过给一个空格，让placeholder与光标有一个小小的间距
    _textField.placeholder = [NSString stringWithFormat:@" %@",placeholder];
    
}

- (IBAction)cancelButtonClicked:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(searchViewCancelButtonClicked)]) {
        [self.delegate searchViewCancelButtonClicked];
    }
}

- (void)textFieldDidChange:(NSNotification *)noti {
    if ([self.delegate respondsToSelector:@selector(searchViewTextFieldDidChanged:)]) {
        [self.delegate searchViewTextFieldDidChanged:noti.object];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // 过滤掉空字符
    NSString *tt = [textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([self isBlankString:textField.text]) {
        
        return NO;
    }
    if ([self.delegate respondsToSelector:@selector(searchViewKeyboardSearchButtonClicked:)]) {
        [self.delegate searchViewKeyboardSearchButtonClicked:tt];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if ([self.delegate respondsToSelector:@selector(searchViewTextfield:shouldChangeCharactersInRange:replacementString:)]) {
        BOOL flag = [self.delegate searchViewTextfield:textField shouldChangeCharactersInRange:range replacementString:string];
        return flag;
    }
    return YES;
}

// 判断是否为空字符串
-  (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
             return YES;
     }
     if ([string isKindOfClass:[NSNull class]]) {
         return YES;
     }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
   }
  return NO;
}


@end
