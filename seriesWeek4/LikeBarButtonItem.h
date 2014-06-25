//
//  LikeBarButtonItem.h
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^LikeBlock)();

@interface LikeBarButtonItem : UIBarButtonItem

- (instancetype)initWithTitle:(NSString *)title block:(LikeBlock)block;

@end
