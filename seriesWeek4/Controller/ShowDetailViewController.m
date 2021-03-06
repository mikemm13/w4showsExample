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
#import "UIAlertView+LikeAlertView.h"
#import "UIImageView+Shows.h"

@interface ShowDetailViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *showDescription;
@property (strong, nonatomic) LikeBarButtonItem *likeBarButton;
@property (weak, nonatomic) IBOutlet UIImageView *showImage;

@end

@implementation ShowDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.tvShow.showTitle;
    self.showDescription.text = self.tvShow.showDescription;
    
    [self.showImage setImageWithURL:[NSURL URLWithString:self.tvShow.posterURL] completion:^(BOOL success) {
        
    }];


    
    //self retenía al botón, el botón retenía al bloque y el bloque retenía de nuevo a self --> Retain Cycle
//    __weak typeof (self) weakSelf = self;
    @weakify(self);
    self.likeBarButton = [[LikeBarButtonItem alloc] initWithTitle:@"Like!" block:^{
//        [weakSelf pressedLikeButton];
        @strongify(self);
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
    UIAlertView *likeAlertView = [[UIAlertView alloc] initWithTitle:@"Like" message:@"Are you sure you want to change the like state of this show?" dismissCallback:^{
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
        
    } cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [likeAlertView show];
    
}

- (void)dealloc{
    //Con un breakpoint aquí vemos si hay un retain cycle
}


@end
