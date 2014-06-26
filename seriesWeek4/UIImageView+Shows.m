//
//  UIImageView+Shows.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 26/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "UIImageView+Shows.h"

@implementation UIImageView (Shows)

- (void)setImageWithURL:(NSURL *)url completion:(void (^)(BOOL success))completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        ///background
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:imageData] ;
        dispatch_async(dispatch_get_main_queue(), ^{
            ///main thread
            if (imageData) {
                self.image = image;
            }
            completion(imageData?YES:NO);
            
            
        });
    });
}

@end
