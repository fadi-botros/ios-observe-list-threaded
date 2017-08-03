//
//  MainDatasource.m
//  TryThreadedAdditionAndRemoval
//
//  Created on 8/3/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "MainDatasource.h"

@implementation MainDatasource

+(instancetype)shared {
    static id _sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [MainDatasource new];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setAllData:[NSMutableArray arrayWithCapacity:16]];
    }
    return self;
}

@end
