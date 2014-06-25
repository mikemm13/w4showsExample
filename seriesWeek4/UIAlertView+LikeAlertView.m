//
//  UIAlertView+LikeAlertView.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "UIAlertView+LikeAlertView.h"
#import <objc/runtime.h>

@interface UIAlertView (LikeAlertViewPrivate)
@property (copy, nonatomic) dismissCallback dismissBlock;
@end

@implementation UIAlertView (LikeAlertView)

- (void)setDismissBlock:(dismissCallback)dismissBlock{
    objc_setAssociatedObject(self, @"block", dismissBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (dismissCallback)dismissBlock{
    dismissCallback dismissCallback = objc_getAssociatedObject(self, @"block");
    return dismissCallback;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
              dismissCallback:(dismissCallback)dismissBlock
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [self initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles, nil];
    if (self) {
        self.dismissBlock = dismissBlock;
    }
    return self;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        self.dismissBlock();
    }
    
}


@end
