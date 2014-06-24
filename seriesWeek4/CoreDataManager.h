//
//  CoreDataManager.h
//  seriesWeek4
//
//  Created by Miguel Martin Nieto on 24/06/14.
//  Copyright (c) 2014 ironhack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
