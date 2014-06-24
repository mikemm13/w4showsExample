//
//  ShowDetailViewController.h
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 24/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShow.h"

@protocol ShowDetailDelegate <NSObject>

- (void)like;
- (void)dislike;

@end

@interface ShowDetailViewController : UIViewController

@property (copy, nonatomic) TVShow *tvShow;
@property (nonatomic) BOOL like;
@property (weak, nonatomic) id delegate;

@end
