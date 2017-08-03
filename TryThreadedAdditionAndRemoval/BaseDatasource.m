//
//  BaseDatasource.m
//  TryThreadedAdditionAndRemoval
//
//  Created on 8/3/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "BaseDatasource.h"

@implementation BaseDatasource

-(NSArray *)allData {
    [NSException raise:NSObjectNotAvailableException format:@"This is to be overridden by subclasses" arguments:NULL];
    return NULL;
}

@end
