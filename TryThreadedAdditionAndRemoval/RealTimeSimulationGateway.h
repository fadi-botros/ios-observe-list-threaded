//
//  RealTimeSimulationGateway.h
//  TryThreadedAdditionAndRemoval
//
//  Created on 8/3/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDatasource.h"

@interface RealTimeSimulationGateway : NSObject

+(instancetype _Nonnull) gatewayWithDatasource:(BaseDatasource<NSString *> *_Nonnull)datasource;

@property (strong, nonnull) BaseDatasource<NSString *>*dataSource;

-(void)start;

@end
