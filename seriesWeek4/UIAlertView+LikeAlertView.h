//
//  UIAlertView+LikeAlertView.h
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^dismissCallback)();
@interface UIAlertView (LikeAlertView) <UIAlertViewDelegate>

- (instancetype) initWithTitle:(NSString *)title
                       message:(NSString *)message
                      dismissCallback:(dismissCallback)dismissBlock
             cancelButtonTitle:(NSString *)cancelButtonTitle
             otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;


@end
