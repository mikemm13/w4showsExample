//
//  ShowDetailViewController.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 24/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "TvShowsTableViewController.h"

@interface ShowDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *showDescription;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation ShowDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.tvShow.showTitle;
    self.showDescription.text = self.tvShow.showDescription;
    if (!self.like) {
        [self.likeButton setTitle:@"Like!" forState:UIControlStateNormal];
    } else {
        [self.likeButton setTitle:@"Not like!" forState:UIControlStateNormal];
    }
    
}


- (IBAction)pressedLikeButton:(id)sender {
    if ([self.likeButton.titleLabel.text isEqualToString:@"Like!"]) {
        TvShowsTableViewController *showsVC = self.delegate;
        [showsVC like];
        [self.likeButton setTitle:@"Not like!" forState:UIControlStateNormal];
    }
    else {
        TvShowsTableViewController *showsVC = self.delegate;
        [showsVC dislike];
        [self.likeButton setTitle:@"Like!" forState:UIControlStateNormal];
    }
    
}

@end
