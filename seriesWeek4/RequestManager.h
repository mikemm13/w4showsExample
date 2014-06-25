//
//  RequestManager.h
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestManagerSuccess)(id);
typedef void(^RequestManagerError)(NSError*);

@interface RequestManager : NSObject

@property (copy, nonatomic) NSString *baseDomain;

- (void)GET:(NSString *)path parameters:(id)parameters successBlock:(RequestManagerSuccess)successBlock errorBlock:(RequestManagerError)errorBlock;

@end
