//
//  ZCCourseHeaderView.m
//  iZhangChu
//
//  Created by Shengping on 17/4/25.
//  Copyright © 2017年 iDress. All rights reserved.
//

#import "ZCCourseHeaderView.h"
#import "ZCCourseHeaderModel.h"
#import "ZCCourseEpisodeModel.h"
#import "ZCPlayImageView.h"
#import "SPButton.h"
#import <UIImageView+WebCache.h>
#import <UIButton+WebCache.h>
#import "ZCMacro.h"

#define kEpisodeButtonPadding 5.0f
#define kMaxCol 8
#define kEpisodeButtonWH (kScreenW-40-(kMaxCol-1)*kEpisodeButtonPadding)/kMaxCol

#define kCourseRelateScrollViewH 145

#define kZanUserBtnWH 40
#define kZanUserBtnPadding 15

#define selfBottomMargin 20

@interface ZCCourseHeaderView()
// 最顶部播放视频的imageView
@property (weak, nonatomic) IBOutlet ZCPlayImageView *videoImageView;
// 上课人数Label
@property (weak, nonatomic) IBOutlet UILabel *numbersOfPersonLabel;
// 收藏Button
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;
// 分享Button
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
// 视频标题的Label
@property (weak, nonatomic) IBOutlet UILabel *videoTitleLabel;
// 视频内容描述的折叠按钮，可收可放
@property (weak, nonatomic) IBOutlet SPButton *contentFoldingButton;
// 视频内容描述的Label
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelConstraintH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seleceEpisodeViewConstraintH;

// 选集Label
@property (weak, nonatomic) IBOutlet UILabel *selectEpisodeLabel;
// 更新至第几集的折叠按钮
@property (weak, nonatomic) IBOutlet SPButton *updateFoldingButton;
// 装每集按钮的容器View
@property (weak, nonatomic) IBOutlet UIView *buttonContainerView;
// 相关课程Label
@property (weak, nonatomic) IBOutlet UILabel *courseRelateLabel;
// 赞的数量Label
@property (weak, nonatomic) IBOutlet UILabel *numbersOfZanLabel;
// 点赞的按钮
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
// 进入赞列表的指示按钮
@property (weak, nonatomic) IBOutlet UIButton *enterZanListButton;
// 点赞用户列表
@property (weak, nonatomic) IBOutlet UIView *zanListView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *zanListViewConstraintH;


// 进入相关课程列表的按钮
@property (weak, nonatomic) IBOutlet UIButton *enterCourseRelateListButton;
// 展示相关课程的scrollView
@property (weak, nonatomic) IBOutlet UIScrollView *courseRelateScrollView;
// scrollView的contentView
@property (weak, nonatomic) IBOutlet UIView *scrollViewContentView;
// scrollView的contentView的宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewContentViewConstraintW;
@property (weak, nonatomic) IBOutlet UIView *emptyCourseView;
@property (weak, nonatomic) IBOutlet UILabel *numbersOfCommentLabel;

@property (weak, nonatomic) IBOutlet SPButton *commitWorkButton;

@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (nonatomic, strong) ZCCourseEpisodeButton *lastSelectedButton;
@end

@implementation ZCCourseHeaderView

+ (instancetype)courseHeaderView {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // 30和10来自于xib
    self.seleceEpisodeViewConstraintH.constant = 30 + 10 + kEpisodeButtonWH*2.0 + 2.0*kEpisodeButtonPadding;
    
    // 跟网络没关系的控件内容设置
    self.selectEpisodeLabel.text = @"选集";
    [self.collectionButton setImage:[UIImage imageNamed:@"foodCourse_collection"] forState:UIControlStateNormal];
    [self.collectionButton setImage:[UIImage imageNamed:@"foodCourse_collection_p"] forState:UIControlStateSelected];
    [self.shareButton setImage:[UIImage imageNamed:@"foodCourse_share"] forState:UIControlStateNormal];
    [self.contentFoldingButton setImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateNormal];
    [self.contentFoldingButton setImage:[UIImage imageNamed:@"expend_up"] forState:UIControlStateSelected];
    [self.updateFoldingButton setImage:[UIImage imageNamed:@"expend_down"] forState:UIControlStateNormal];
    [self.updateFoldingButton setImage:[UIImage imageNamed:@"expend_up"] forState:UIControlStateSelected];
    self.updateFoldingButton.imagePosition = SPButtonImagePositionRight;
    self.updateFoldingButton.titleLabel.alpha = 0.5;
    self.updateFoldingButton.imageRatio = 0.2;
    
    [self.zanButton setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
    [self.zanButton setImage:[UIImage imageNamed:@"agree_p"] forState:UIControlStateSelected];
    [self.enterZanListButton setImage:[UIImage imageNamed:@"ArrowRight"] forState:UIControlStateNormal];
    self.courseRelateLabel.text = @"相关课程";
    [self.enterCourseRelateListButton setImage:[UIImage imageNamed:@"ArrowRight"] forState:UIControlStateNormal];
    [self.commitWorkButton setImage:[UIImage imageNamed:@"handleClass"] forState:UIControlStateNormal];
    [self.commitWorkButton setTitle:@"交作业" forState:UIControlStateNormal];
    self.commitWorkButton.imagePosition = SPButtonImagePositionTop;
    [self.commitWorkButton setTitleColor:ZCGlobalColor forState:UIControlStateNormal];
    self.commitWorkButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    // xib中设置的RGB颜色有偏差
    self.commentButton.backgroundColor = ZCColorRGBA(243, 123, 81, 1);
  
    // 延迟0.01s的目的是：xib加载完可能frame还没有立即生效，所以延迟一点点
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.zc_height = CGRectGetMaxY(self.commentButton.frame) + selfBottomMargin;
    });
}

- (void)setHeaderModel:(ZCCourseHeaderModel *)headerModel {
    _headerModel = headerModel;
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:headerModel.series_image] placeholderImage:nil];
    [self.updateFoldingButton setTitle:[NSString stringWithFormat:@"更新至第%zd集",headerModel.episode] forState:UIControlStateNormal];
    
    for (int i = 0; i < headerModel.data.count; i++) {
        ZCCourseEpisodeModel *episodeModel = headerModel.data[i];
        ZCCourseEpisodeButton *episodeBtn = [[ZCCourseEpisodeButton alloc] init];
        // 给button传递模型,这样，每一个按钮都绑定着一个模型，拿到了button就等于拿到了模型
        episodeBtn.episodeModel = episodeModel;
        episodeBtn.backgroundColor = ZCColorRGBA(245, 245, 245, 1);
        [episodeBtn setBackgroundImage:[UIImage imageWithColor:ZCGlobalColor] forState:UIControlStateSelected];
        [episodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        episodeBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [episodeBtn addTarget:self action:@selector(episodeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if (episodeModel.episode == headerModel.episode) {
            // 更新至第几集，就默认选中第几个按钮
            [self episodeBtnClicked:episodeBtn];
        }
        [self.buttonContainerView addSubview:episodeBtn];
    }
    [self layoutEpisodeButtons];
    
}

- (void)setCourseRelateModel:(ZCCourseRelateModel *)courseRelateModel {
    _courseRelateModel = courseRelateModel;
    if (courseRelateModel.data.count <= 0) {
        self.scrollViewContentViewConstraintW.constant = kScreenW;
        self.emptyCourseView.hidden = NO;
        return;
    }

    CGFloat dishViewW = 120.0f;
    
    // 如果在xib或storyBoard中使用scrollView，建议在scrollView上添加一张与scrollView同等大小的contentview.
    // 当在scrollView上添加一张同等大小的contentView时(上下左右均为0)，xib约束会报红，解决方法如下:
    // 1.给contentView添加一个水平或垂直约束，如果是水平滚动，添加垂直约束，如果是垂直滚动，则添加水平约束
    // 2.给contentView一个宽度（高度）约束，水平滚动就设置宽度约束 ，垂直滚动就设置高度约束，该约束即决定scrollView的contentSize
    
    NSInteger count = courseRelateModel.data.count;
    
    CGFloat dishViewPadding = 0.5;
    
    // 设置scrollView的contentSize
    self.scrollViewContentViewConstraintW.constant = count * dishViewW + (count-1)*dishViewPadding;
    
    for (int i = 0; i < count; i++) {
        ZCCourseDishesView *dishView = [[ZCCourseDishesView alloc] init];
        ZCCourseMediaModel *media = courseRelateModel.data[i];
        dishView.dish = media.relation;
        dishView.translatesAutoresizingMaskIntoConstraints = NO;
        // 添加到scrollView的contentView上
        [self.scrollViewContentView addSubview:dishView];
        [dishView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(i*(dishViewW+dishViewPadding));
            make.top.equalTo(0);
            make.width.equalTo(dishViewW);
            make.height.equalTo(kCourseRelateScrollViewH);
        }];
    }
}

- (void)setZanModel:(ZCCourseZanModel *)zanModel {
    _zanModel = zanModel;
    
    self.numbersOfZanLabel.text = [NSString stringWithFormat:@"%ld位厨友觉得很赞",zanModel.data.count];
    if (!zanModel.data.count) {
        self.zanListViewConstraintH.constant = 0;
    }  else if (zanModel.data.count > 4) {
        for (int i = 0; i < 4; i++) { // 最多摆4个
            [self setupZanUserButtonWithScript:i];
            self.enterZanListButton.hidden = NO;
        }
    } else {
        for (int i = 0; i < zanModel.data.count; i++) {
            [self setupZanUserButtonWithScript:i];
        }
    }
}

- (void)setupZanUserButtonWithScript:(NSInteger)script {
    ZCCourseZanUser *user = self.zanModel.data[script];
    ZCCourseZanUserButton *btn = [[ZCCourseZanUserButton alloc] init];
    btn.zanUser = user;
    [self.zanListView addSubview:btn];
    [btn makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(0);
        make.left.equalTo(script * (kZanUserBtnWH+kZanUserBtnPadding));
        make.width.height.equalTo(kZanUserBtnWH);
    }];
    
}

- (void)setCommentCount:(NSInteger)commentCount {
    _commentCount = commentCount;
    self.numbersOfCommentLabel.text = [NSString stringWithFormat:@"%ld条发言",commentCount];
}

#pragma mark 按钮点击方法
// 收藏按钮被点击
- (IBAction)collectButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

// 分享按钮被点击
- (IBAction)shareButtonClicked:(UIButton *)sender {
    
}

// 视频文字内容折叠按钮被点击
- (IBAction)contentFoldingButtonClicked:(SPButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        self.contentLabelConstraintH.constant = [self.contentLabel.text boundingRectWithSize:CGSizeMake(kScreenW-40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.contentLabel.font} context:nil].size.height;
        
    } else {
        self.contentLabelConstraintH.constant = 0;
    }
    
    // UIView动画，以上代码放在UIView的block块内部是无效的
    [UIView animateWithDuration:0.25 animations:^{
        // 强制布局，尝试过用contentLabel本身调用layoutIfNeeded无效
        [self layoutIfNeeded];
    }];
 
    self.zc_height = CGRectGetMaxY(self.commentButton.frame) + selfBottomMargin;

}

// 更新至第几集的按钮被点击(折叠)
- (IBAction)updateFoldingButtonClicked:(SPButton *)sender {
    
    sender.selected = !sender.selected;
    
    NSInteger count = self.headerModel.data.count;
    
    if (sender.selected) {
        self.seleceEpisodeViewConstraintH.constant = 30 + 10 + (count + kMaxCol) / kMaxCol * kEpisodeButtonWH + ((count + kMaxCol) / kMaxCol - 1) * kEpisodeButtonPadding + kEpisodeButtonPadding;
    } else {
        self.seleceEpisodeViewConstraintH.constant = 30 + 10 + kEpisodeButtonWH*2.0 + 2.0*kEpisodeButtonPadding;
    }
    
    // UIView动画，以上代码放在UIView的block块内部是无效的
    [UIView animateWithDuration:0.25 animations:^{
        [self layoutIfNeeded];
    }];

    self.zc_height = CGRectGetMaxY(self.commentButton.frame) + selfBottomMargin;
}

// 赞的按钮被点击
- (IBAction)zanButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

// 进入赞的列表
- (IBAction)enterZanListButtonClicked:(UIButton *)sender {
    
}

// 进入相关课程列表
- (IBAction)enterCourseRelateListButtonClicked:(UIButton *)sender {
    
}

// 交作业按钮被点击
- (IBAction)commitWorkButtonClicked:(SPButton *)sender {
}

// 发言(评论)按钮被点击
- (IBAction)commentButtonClicked:(UIButton *)sender {
}

// 每一集的按钮点击方法
- (void)episodeBtnClicked:(ZCCourseEpisodeButton *)sender {
    // 这三行代码决定选中的按钮和未选中按钮的颜色
    self.lastSelectedButton.selected = NO;
    sender.selected = YES;
    self.lastSelectedButton = sender;
    
    [self.videoImageView sd_setImageWithURL:[NSURL URLWithString:sender.episodeModel.course_image] placeholderImage:nil];
    self.numbersOfPersonLabel.text = [NSString stringWithFormat:@"上课人数:%zd",sender.episodeModel.video_watchcount];
    self.videoTitleLabel.text = sender.episodeModel.course_name;
    self.contentLabel.text = sender.episodeModel.course_subject;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(headerViewEpisodeButtonClicked:)]) {
        [self.delegate headerViewEpisodeButtonClicked:sender];
    }
    
}

- (void)layoutEpisodeButtons {
    
    __block int i = 0;
    [self.buttonContainerView.subviews makeConstraints:^(MASConstraintMaker *make) {
        NSInteger col = i % kMaxCol;
        NSInteger row = i / kMaxCol;
        make.top.equalTo(row * (kEpisodeButtonWH+kEpisodeButtonPadding));
        make.left.equalTo(col * (kEpisodeButtonWH+kEpisodeButtonPadding));
        make.size.equalTo(CGSizeMake(kEpisodeButtonWH, kEpisodeButtonWH));
        i++;
    }];
}


@end



@implementation ZCCourseEpisodeButton

- (void)setEpisodeModel:(ZCCourseEpisodeModel *)episodeModel {
    _episodeModel = episodeModel;
    [self setTitle:[NSString stringWithFormat:@"%zd",episodeModel.episode] forState:UIControlStateNormal];
}

@end


#import "ZCPlayImageView.h"

@interface ZCCourseDishesView()
@property (nonatomic, strong) ZCPlayImageView *playImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation ZCCourseDishesView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.playImageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)setDish:(ZCCourseDishesModel *)dish {
    _dish = dish;
    [self.playImageView sd_setImageWithURL:[NSURL URLWithString:dish.dishes_image] placeholderImage:nil];
    self.titleLabel.text = dish.dishes_title;
}

- (ZCPlayImageView *)playImageView {
    
    if (!_playImageView) {
        _playImageView = [[ZCPlayImageView alloc] init];
        _playImageView.contentMode = UIViewContentModeScaleAspectFill;
        _playImageView.layer.masksToBounds = YES;
        
    }
    return _playImageView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.alpha = 0.6;
    }
    return _titleLabel;
}

- (void)updateConstraints {
    [self.playImageView makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(0);
        make.bottom.equalTo(self.titleLabel.top).offset(-5);
    }];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(5);
        make.right.equalTo(-5);
        make.bottom.equalTo(0);
        make.height.equalTo(20);
        make.top.equalTo(self.playImageView.bottom).offset(5);
    }];
    
    [super updateConstraints];
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

@end



@implementation ZCCourseZanUserButton

- (void)setZanUser:(ZCCourseZanUser *)zanUser {
    _zanUser = zanUser;

    [self sd_setImageWithURL:[NSURL URLWithString:zanUser.head_img] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"userHeadImage"] options:SDWebImageRetryFailed completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image) {
            [self setImage:[image circleImage] forState:UIControlStateNormal];
        } else {
            [self setImage:[UIImage imageNamed:@"userHeadImage"] forState:UIControlStateNormal];
        }
    }];

}

@end







