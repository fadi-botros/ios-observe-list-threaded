//
//  MainDatasource.h
//  TryThreadedAdditionAndRemoval
//
//  Created on 8/3/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDatasource.h"

@interface MainDatasource : BaseDatasource<NSString *>

@property (class, readonly, strong, nonnull) MainDatasource *shared;

@property (strong, nonnull) NSMutableArray *allData;

@end
