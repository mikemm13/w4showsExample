//
//  ShowsProvider.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "ShowsProvider.h"
#import "TVShow.h"

@implementation ShowsProvider


- (void)getListOfShowsWithSuccessBlock:(RequestManagerSuccess)successBlock errorBlock:(RequestManagerError)errorBlock{

    RequestManager *requestManager = [[RequestManager alloc] init];
    [requestManager GET:@"shows.json" parameters:nil successBlock:^(NSDictionary *data) {
        NSMutableArray *shows = [[NSMutableArray alloc] init];
        for (NSDictionary* tvShowDictionary in [data valueForKey:@"shows"]) {
            NSError *parseError;
            TVShow *showItem = [MTLJSONAdapter modelOfClass:[TVShow class] fromJSONDictionary:tvShowDictionary error:&parseError];
            [shows addObject:showItem];
        }
        successBlock(shows);
    } errorBlock:^(NSError * error) {
        errorBlock(error);
    }];
    
}

@end
