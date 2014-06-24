//
//  TVShows.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 23/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "TVShow.h"
static NSString *savedShowsFileName = @"shows";
@interface TVShow ()

@end


@implementation TVShow

+ (NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"showDescription": @"description",
             @"showTitle":@"title",
             @"showId":@"id"};
}

@end
