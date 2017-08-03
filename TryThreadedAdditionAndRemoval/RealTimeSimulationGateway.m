//
//  RealTimeSimulationGateway.m
//  TryThreadedAdditionAndRemoval
//
//  Created on 8/3/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "RealTimeSimulationGateway.h"

@implementation RealTimeSimulationGateway

+(instancetype _Nonnull) gatewayWithDatasource:(BaseDatasource<NSString *> *_Nonnull)datasource {
    RealTimeSimulationGateway *ret = [RealTimeSimulationGateway new];
    [ret setDataSource:datasource];
    return ret;
}

-(void) start {
    NSMutableArray *dataToChange = [self.dataSource mutableArrayValueForKey:@"allData"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        NSLog(@"Adding string1");
        [dataToChange addObject:@"String1"];
        NSLog(@"Adding string2");
        [dataToChange addObject:@"String2"];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0), ^{
        NSLog(@"Adding string3");
        [dataToChange addObject:@"String3"];
        NSLog(@"removing indexed 1");
        [dataToChange removeObjectAtIndex:1];
        NSLog(@"Adding string4");
        [dataToChange addObject:@"String4"];
    });
}

@end
