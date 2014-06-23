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

- (id)copyWithZone:(NSZone *)zone{
    TVShow *tvShow = [[[self class] allocWithZone:zone] init];
    if (tvShow) {
        tvShow.showId = [self.showId copyWithZone:zone];
        tvShow.showTitle = [self.showTitle copyWithZone:zone];
        tvShow.showDescription = [self.showDescription copyWithZone:zone];
        tvShow.showRating = self.showRating;
    }
    return tvShow;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.showId = [aDecoder decodeObjectForKey:@"showId"];
        self.showTitle = [aDecoder decodeObjectForKey:@"showTitle"];
        self.showDescription = [aDecoder decodeObjectForKey:@"showDescription"];
        NSNumber *priceNumber = [aDecoder decodeObjectForKey:@"showRating"];
        self.showRating = CGFLOAT_IS_DOUBLE?[priceNumber doubleValue]:[priceNumber floatValue];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.showId forKey:@"showId"];
    [aCoder encodeObject:self.showTitle forKey:@"showTitle"];
    [aCoder encodeObject:self.showDescription forKey:@"showDescription"];
    NSNumber *priceNumber = CGFLOAT_IS_DOUBLE? [NSNumber numberWithDouble:self.showRating]:[NSNumber numberWithFloat:self.showRating];
    [aCoder encodeObject:priceNumber forKey:@"showRating"];

}

- (BOOL)isEqualToShow:(TVShow *)show{
    if(![self.showId isEqualToString:show.showId]){
        NSLog(@"No equal");
        return NO;
    }
    if(![self.showTitle isEqualToString:show.showTitle]){
        NSLog(@"No equal");
        return NO;
    }
    if(![self.showDescription isEqualToString:show.showDescription]){
        NSLog(@"No equal");
        return NO;
    }
    if(!self.showRating == show.showRating){
        NSLog(@"No equal");
        return NO;
    }
    NSLog(@"Both objects are equal");
    return YES;
}

- (BOOL)isEqual:(id)anObject{
    if(self==anObject){
        return YES;
    }
    if(![anObject isKindOfClass:[self class]]){
        return NO;
    }
    return [self isEqualToShow:(TVShow *)anObject];
}

- (NSUInteger) hash{
    return [_showId hash];
}

@end
