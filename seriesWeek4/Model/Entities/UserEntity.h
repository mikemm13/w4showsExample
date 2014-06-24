//
//  UserEntity.h
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 24/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserEntity : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * userId;
@property (nonatomic, retain) NSString * userPassword;

@end
