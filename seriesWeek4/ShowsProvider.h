//
//  ShowsProvider.h
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestManager.h"

@interface ShowsProvider : NSObject

- (void)getListOfShowsWithSuccessBlock:(RequestManagerSuccess)successBlock errorBlock:(RequestManagerError)errorBlock;

@end
