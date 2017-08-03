//
//  BaseDatasource.h
//  TryThreadedAdditionAndRemoval
//
//  Created on 8/3/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDatasource<T: NSObject *> : NSObject

/**
 This is to be overridden by subclasses, this is a getter that gets all data

 @return All the data
 */
-(NSMutableArray<T> *)allData;

@end
