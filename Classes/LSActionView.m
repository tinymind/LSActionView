//
//  LSActionView.m
//  LSActionViewDemo
//
//  Created by lslin on 15/2/5.
//  Copyright (c) 2015年 LessFun.com. All rights reserved.
//

#import "LSActionView.h"

static const CGFloat kLSActionViewDefaultButtonSpacing = 26;

@interface LSActionView()

@property (copy, nonatomic) LSActionBlock handleBlock;
@property (strong, nonatomic) UIView *containerView;
@property (assign, nonatomic) NSInteger countPerLine;/**< number of buttons in one line, default is 4 */
@property (assign, nonatomic) CGFloat buttonSpacing;
@property (assign, nonatomic) CGFloat leftMargin;

@end

@implementation LSActionView

#pragma mark - Static

+ (instancetype)sharedActionView
{
    static LSActionView *actionView = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        actionView = [[LSActionView alloc] init];
    });
    return actionView;
}

#pragma mark -

- (id)init
{
    if (self = [super init]) {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onBackgroundTapped:)];
        [self addGestureRecognizer:tapGesture];
        
        _buttonIconWidth = 44;
        _buttonTitleHeight = 20;
        _containerMargin = 20;
        _buttonFontSize = 11;

        _containerView = [UIView new];
        [self addSubview:_containerView];
        
        self.blankAreaColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.containerColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.8];
        self.buttonTitleColor = [UIColor darkGrayColor];
    }
    return self;
}

#pragma mark - Public

- (void)showWithImages:(NSArray *)images
           actionBlock:(LSActionBlock)block
{
    if (images.count == 0) {
        return;
    }
    
    [self configWithImages:images titles:nil block:block];
}

- (void)showWithImages:(NSArray *)images
                titles:(NSArray *)titles
           actionBlock:(LSActionBlock)block;
{
    if (images.count == 0 || titles.count != images.count) {
        return;
    }
    
    [self configWithImages:images titles:titles block:block];
}

- (void)dismiss
{
    [self removeFromSuperview];
}

#pragma mark - Property

- (void)setBlankAreaColor:(UIColor *)blankAreaColor
{
    _blankAreaColor = blankAreaColor;
    self.backgroundColor = _blankAreaColor;
}

- (void)setContainerColor:(UIColor *)containerColor
{
    _containerColor = containerColor;
    self.containerView.backgroundColor = containerColor;
}

#pragma mark - Action

- (void)onBackgroundTapped:(id)sender
{
    [self dismiss];
}

- (void)onButtonClicked:(UIButton *)btn
{
    if (self.handleBlock) {
        self.handleBlock(btn.tag);
    }
    [self dismiss];
}

#pragma mark - Private

- (void)configWithImages:(NSArray *)images titles:(NSArray *)titles block:(LSActionBlock)block
{
    if (![self superview]) {
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        self.frame = [[UIScreen mainScreen] bounds];
        [window addSubview:self];
    }
    
    self.handleBlock = block;
    
    NSInteger count = images.count;
    BOOL showTitle = titles.count > 0;
    [self configContainerViewWithCount:count showTitle:showTitle];
    [self configButtonsWithTitles:titles images:images showTitle:showTitle];
}

- (void)configContainerViewWithCount:(NSInteger)count showTitle:(BOOL)showTitle
{
    [_containerView.subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    
    CGFloat width = self.frame.size.width;
    CGFloat titleHeight = showTitle ? _buttonTitleHeight : 0;
    _countPerLine = (width - _containerMargin * 2) / (_buttonIconWidth + kLSActionViewDefaultButtonSpacing);
    
    NSInteger lines = ceil((CGFloat)count / _countPerLine);
    CGFloat height = (_buttonIconWidth + titleHeight + _containerMargin) * lines + _containerMargin;
    _containerView.frame = CGRectMake(0, self.frame.size.height - height, width, height);
    
    _leftMargin = _containerMargin;
    if (count < _countPerLine) {
        _leftMargin += _containerMargin * (_countPerLine - count);
    }
    
    NSInteger realCount = MIN(count, _countPerLine);
    _buttonSpacing = (self.frame.size.width - _leftMargin * 2 - _buttonIconWidth * realCount) / (realCount - 1);
}

- (void)configButtonsWithTitles:(NSArray *)titles images:(NSArray *)images showTitle:(BOOL)showTitle
{
    CGFloat x = _leftMargin;
    CGFloat y = _containerMargin;
    CGFloat titleHeight = showTitle ? _buttonTitleHeight : 0;
    for (int i = 0; i < images.count; ++ i) {
        
        [self addButtonWithTag:i title:showTitle ? titles[i] : nil image:images[i] xOffset:x yOffset:y];
        
        x += _buttonIconWidth + _buttonSpacing;
        if (i > 0  && (i + 1) % _countPerLine == 0) {
            y += _containerMargin + _buttonIconWidth + titleHeight;
            x = _leftMargin;
        }
    }
}

- (void)addButtonWithTag:(int)tag title:(NSString *)title image:(NSString *)image xOffset:(CGFloat)xOffset yOffset:(CGFloat)yOffset
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(xOffset, yOffset, _buttonIconWidth, _buttonIconWidth + (title.length ? _buttonTitleHeight : 0))];
    button.tag = tag;

    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    if (title.length) {
        button.titleLabel.font = [UIFont systemFontOfSize:_buttonFontSize];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
        [self centerButtonImageAndTitle:button];
    }
    
    [self.containerView addSubview:button];
}

- (void)centerButtonImageAndTitle:(UIButton *)btn
{
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn.titleLabel sizeToFit];
//    btn.titleLabel.adjustsFontSizeToFitWidth = YES;
    
    CGSize imageSize = btn.imageView.frame.size;
    CGSize titleSize = btn.titleLabel.frame.size;
    
    CGFloat totalHeight = btn.frame.size.height;
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height),
                                           0.0f,
                                           0.0f,
                                           - titleSize.width);
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0.0f,
                                           - imageSize.width,
                                           - (totalHeight - titleSize.height - 2),
                                           0.0f);
}

@end
