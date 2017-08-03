//
//  MainViewModel.h
//  TryThreadedAdditionAndRemoval
//
//  Created on 8/3/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainDatasource.h"

/**
 Here is the core of the action.
 An object that observes on the datasource, any change in the datasource must be reflected, but how?
 There IS an array here, that STORES the current state, any change are put on a dispatch queue
 Then the UI is to be updated and this update will be on the same queue, this will make the changes
 intermittent, not direct, but as real-time as possible
 */
@interface MainViewModel : NSObject

-(instancetype)initWithDatasource:(MainDatasource *) datasource;

@property (strong, nonatomic, readonly) MainDatasource *dataSource;
/**
 This is the local place that saves the "current" data, this will be lagged version of the main
 datasource, this is to be compatible with the TableView
 */
@property (strong, nonatomic, readonly) NSMutableArray<NSString *> *localData;

/**
 The dispatch queue that is to be used to update the TableView (will be Synced with the main thread)
 This is to guarantee that the localData is compatible with datasource (change of localData will be
 in the same queue that updatas the TableView)
 */
@property (readonly) dispatch_queue_t dataSourceQueue;

/**
 Starts the Simulation gateway
 TODO: - Make an interactor or repository layer in between, to make it easily changable
 */
-(void)getData;

@end
