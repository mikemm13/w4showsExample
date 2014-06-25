//
//  ShowDetailViewController.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 24/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "TvShowsTableViewController.h"
#import "LikeBarButtonItem.h"

@interface ShowDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *showDescription;
@property (strong, nonatomic) LikeBarButtonItem *likeBarButton;

@end

@implementation ShowDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.tvShow.showTitle;
    self.showDescription.text = self.tvShow.showDescription;
    
    self.likeBarButton = [[LikeBarButtonItem alloc] initWithTitle:@"Like!" block:^{
        [self pressedLikeButton];
    }];
    
    self.navigationItem.rightBarButtonItem = self.likeBarButton;
    if (!self.like) {
        [self.likeBarButton setTitle:@"Like!" ];
    } else {
        [self.likeBarButton setTitle:@"Not like!" ];
    }
    
}


- (void)pressedLikeButton {
    if ([self.likeBarButton.title isEqualToString:@"Like!"]) {
        TvShowsTableViewController *showsVC = self.delegate;
        [showsVC like];
        [self.likeBarButton setTitle:@"Not like!"];
    }
    else {
        TvShowsTableViewController *showsVC = self.delegate;
        [showsVC dislike];
        [self.likeBarButton setTitle:@"Like!"];
    }
    
}

@end
