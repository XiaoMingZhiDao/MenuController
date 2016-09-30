//
//  MDJLabel.m
//  MDJMenuController
//
//  Created by MDJ on 16/9/29.
//  Copyright © 2016年 MDJ. All rights reserved.
//

#import "MDJLabel.h"

@implementation MDJLabel

- (void)awakeFromNib
{
    [self setup];
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

// 让label有资格成为第一响应者
- (BOOL)canBecomeFirstResponder
{
    return YES;
}

// label 能执行哪些操作（比如copy，paste ...）
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(cut:) || action == @selector(paste:) || action == @selector(copy:))
        return YES;
    
    return  NO;
}

- (void)cut:(UIMenuController *)menu
{
   
    [self copy:menu];
    // 清空文字
    self.text = nil;
}

- (void)copy:(UIMenuController *)menu
{
    // 讲自己的文字赋值的粘贴板
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    board.string = self.text;
}


- (void)paste:(UIMenuController *)menu
{
    // 讲自己的文字赋值的粘贴板
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    self.text =  board.string ;
}


- (void)setup
{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelClick)]];
}

- (void)labelClick
{
    // label 要成为第一响应者
    [self becomeFirstResponder];
    
    // 显示 MenuController
    // targetRect:需要指向的矩形框
    // targetView:targetRect会以targetView的左上角为坐标原点
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:self.bounds inView:self];
    [menu setMenuVisible:YES animated:YES];
}

@end
