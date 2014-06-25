//
//  LikeBarButtonItem.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "LikeBarButtonItem.h"

@interface LikeBarButtonItem ()

@property (copy, nonatomic) LikeBlock block;

@end

@implementation LikeBarButtonItem

-(instancetype)initWithTitle:(NSString *)title block:(LikeBlock)block{
    self = [super initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(buttonAction)];
    if (self) {
        _block = block;
    }
    return self;
}

- (void)buttonAction
{
    self.block();
}

@end
