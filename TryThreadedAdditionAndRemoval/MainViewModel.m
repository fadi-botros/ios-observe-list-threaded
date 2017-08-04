//
//  MainViewModel.m
//  TryThreadedAdditionAndRemoval
//
//  Created on 8/3/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "MainViewModel.h"
#import "RealTimeSimulationGateway.h"

@implementation MainViewModel

static void *pContext = &pContext;

- (instancetype)initWithDatasource:(BaseDatasource<NSString *> *)datasource
{
    self = [super init];
    if (self) {
        _dataSource = MainDatasource.shared;
        [_dataSource addObserver:self forKeyPath:@"allData" options:0 context:pContext];
        _dataSourceQueue = dispatch_queue_create_with_target(nil, dispatch_queue_attr_make_with_qos_class(DISPATCH_QUEUE_SERIAL, QOS_CLASS_DEFAULT, 0), DISPATCH_TARGET_QUEUE_DEFAULT);
        _localData = [NSMutableArray arrayWithCapacity:16];
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"allData"];
}

- (void) getData {
    [[RealTimeSimulationGateway gatewayWithDatasource:MainDatasource.shared] start];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == pContext) {
        NSValue *kind = [change objectForKey:NSKeyValueChangeKindKey];
        NSIndexSet *indexSet = [change objectForKey:NSKeyValueChangeIndexesKey];
        if ([kind isEqualToValue:@(NSKeyValueChangeInsertion)]) {
            [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                // Get the value NOW because it may be deleted afterwards
                NSString *value = [self.dataSource.allData objectAtIndex:idx];
                dispatch_async(self.dataSourceQueue, ^(void) {
                    NSLog(@"%lu, %@", (unsigned long)idx, value);
                    [[self mutableArrayValueForKey:@"localData"] addObject:value];
                });
            }];
        } else if ([kind isEqualToValue:@(NSKeyValueChangeRemoval)]) {
            [indexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                dispatch_async(self.dataSourceQueue, ^(void) {
                    NSLog(@"%lu", (unsigned long)idx);
                    [[self mutableArrayValueForKey:@"localData"] removeObjectAtIndex:idx];
                });
            }];
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
