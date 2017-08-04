//
//  ViewController.m
//  TryThreadedAdditionAndRemoval
//
//  Created on 8/3/17.
//  Copyright © 2017 experiments. All rights reserved.
//

#import "ViewController.h"
#import "MainViewModel.h"
#import "MainDatasource.h"

@interface ViewController ()

@end

@implementation ViewController {
    MainViewModel *viewModel;
    __weak IBOutlet UITableView *tableView;
}

static void *pContext = &pContext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    viewModel = [[MainViewModel alloc] initWithDatasource:MainDatasource.shared];
    [viewModel addObserver:self forKeyPath:@"localData" options:0 context:pContext];
    [viewModel getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return viewModel.localData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [[cell textLabel] setText:[viewModel.localData objectAtIndex:indexPath.row]];
    return cell;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == pContext) {
        NSKeyValueChange kind = [[change objectForKey:NSKeyValueChangeKindKey] unsignedIntegerValue];
        NSIndexSet *indexes = [change objectForKey:NSKeyValueChangeIndexesKey];
        if (kind == NSKeyValueChangeInsertion) {
            // Sync it, to make the UI thread wait until changes are stable, and make sure no
            // other changes in localData will happen until the change happens on the UI, localData
            // will WAIT until update happens then resume to be updated by the main data
            NSLog(@"Entering main queue");
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                NSLog(@"Entered main queue");
                [tableView beginUpdates];
                [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                    NSLog(@"Inserting %lu", (unsigned long)idx);
                    [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]]
                                     withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
                [tableView endUpdates];
            });
        } else if (kind == NSKeyValueChangeRemoval) {
            dispatch_sync(dispatch_get_main_queue(), ^(void) {
                [tableView beginUpdates];
                [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
                    NSLog(@"Deleting %lu", (unsigned long)idx);
                    [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:idx inSection:0]]
                                     withRowAnimation:UITableViewRowAnimationAutomatic];
                }];
                [tableView endUpdates];
            });
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end
