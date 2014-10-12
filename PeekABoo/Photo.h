//
//  Photo.h
//  PeekABoo
//
//  Created by Basel Farag on 8/16/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Photo : NSManagedObject

@property (nonatomic, retain) NSData * data;
@property (nonatomic, retain) NSManagedObject *user;

@end
