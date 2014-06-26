//
//  UIImageView+Shows.h
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 26/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Shows)

- (void) setImageWithURL:(NSURL *)url completion:(void (^)(BOOL success))completion;

@end
