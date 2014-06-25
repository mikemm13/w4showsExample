//
//  RequestManager.m
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 25/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import "RequestManager.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>

@implementation RequestManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _baseDomain = @"http://ironhack4thweek.s3.amazonaws.com";
    }
    return self;
}

- (void)GET:(NSString *)path parameters:(id)parameters successBlock:(RequestManagerSuccess)successBlock errorBlock:(RequestManagerError)errorBlock{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:[self.baseDomain stringByAppendingPathComponent:path]
      parameters:parameters
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             successBlock(responseObject);
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             errorBlock(error);
         }
     ];
}

@end
