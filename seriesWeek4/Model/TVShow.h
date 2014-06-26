//
//  TVShows.h
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 23/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface TVShow : MTLModel <MTLJSONSerializing>

@property (copy, nonatomic) NSString *showId;
@property (copy, nonatomic) NSString *showDescription;
@property (copy, nonatomic) NSString *showTitle;
@property (assign, nonatomic) CGFloat showRating;
@property (copy, nonatomic) NSString *posterURL;

+ (NSDictionary *)JSONKeyPathsByPropertyKey;


@end
