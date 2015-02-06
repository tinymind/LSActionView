//
//  LSActionView.h
//  LSActionViewDemo
//
//  Created by lslin on 15/2/5.
//  Copyright (c) 2015年 LessFun.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LSActionBlock)(NSInteger index);

@interface LSActionView : UIView

@property (strong, nonatomic) UIColor *blankAreaColor;     /**< default is black color with 0.4 alpha */
@property (strong, nonatomic) UIColor *containerColor;     /**< default is white color with 0.8 alpha */
@property (strong, nonatomic) UIColor *buttonTitleColor;   /**< default is darkGrayColor */
@property (assign, nonatomic) CGFloat buttonFontSize;      /**< default is 11 */
@property (assign, nonatomic) CGFloat containerMargin;     /**< default is 20 */
@property (assign, nonatomic) CGFloat buttonIconWidth;     /**< button width, default is 44, button's height = buttonIconWidth + buttonTitleHeight */
@property (assign, nonatomic) CGFloat buttonTitleHeight;   /**< button title height, default is 20 */

/**
 *  Single instance of LSActionView
 *
 *  @return LSActionView instance
 */
+ (instancetype)sharedActionView;

/**
 *  init a LSActionView
 *
 *  @return LSActionView instance
 */
- (id)init;

/**
 *  show LSActionView on UIScreen without button title.
 *
 *  @param images button icons
 *  @param block  button touch callback
 */
- (void)showWithImages:(NSArray *)images
           actionBlock:(LSActionBlock)block;

/**
 *  show LSActionView on UIScreen with button title.
 *
 *  @param images button icons
 *  @param titles button titles
 *  @param block  button touch callback
 */
- (void)showWithImages:(NSArray *)images
                titles:(NSArray *)titles
           actionBlock:(LSActionBlock)block;

/**
 *  dismiss LSActionView
 */
- (void)dismiss;

@end
