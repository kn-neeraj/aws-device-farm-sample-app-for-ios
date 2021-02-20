/* * Copyright 2014-2015 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 * http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */


#import "ElementsTableViewController.h"
#import "UIColor+ColorExtension.h"

@interface ElementsTableViewController ()

@end
static NSString* const CELL_IDENTIFIER = @"elementTableCell";
static NSUInteger const NUMBER_OF_CELLS = 40;
static NSUInteger const NUMBER_OF_SECTIONS = 1;

/**
 *  A table list view controller
 */
@implementation ElementsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor flatDarkOffWhite];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CELL_IDENTIFIER];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return NUMBER_OF_SECTIONS;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return NUMBER_OF_CELLS;
}

/**
 *  Creates the cells and sets the text
 *
 *  The text is just the index
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%li",(long)indexPath.row];
    
    // create gestures
    UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:NSSelectorFromString(@"singleTap:")];
    singleTapGesture.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *twoFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:NSSelectorFromString(@"doubleFingerSingleTap:")];
    twoFingerTap.numberOfTapsRequired = 1;
    twoFingerTap.numberOfTouchesRequired = 2;
    
    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:NSSelectorFromString(@"doubleTap:")];
    doubleTapGesture.numberOfTapsRequired = 2;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:NSSelectorFromString(@"longPress:")];
    
    [singleTapGesture requireGestureRecognizerToFail:longPress];
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    [singleTapGesture requireGestureRecognizerToFail:twoFingerTap];
    
    //Remove all gestures
    while (cell.contentView.gestureRecognizers.count) {
        [cell.contentView removeGestureRecognizer:[cell.contentView.gestureRecognizers objectAtIndex:0]];
    }
   
    //Add Gestures
    cell.contentView.userInteractionEnabled = true;
    [cell.contentView addGestureRecognizer:singleTapGesture];
    [cell.contentView addGestureRecognizer:twoFingerTap];
    [cell.contentView addGestureRecognizer:doubleTapGesture];
    [cell.contentView addGestureRecognizer:longPress];
    cell.contentView.accessibilityIdentifier = [NSString stringWithFormat:@"%ld", (long)indexPath.row];

    
    return cell;
}

- (void)singleTap:(UITapGestureRecognizer *)sender {
    CGPoint touch = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touch];
    NSString *alertMessage = [NSString stringWithFormat:@"Single tap at index : %ld", (long)indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Gesture Alert" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:NO completion:nil];
}

- (void)doubleFingerSingleTap:(UITapGestureRecognizer *)sender {
    CGPoint touch = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touch];
    NSString *alertMessage = [NSString stringWithFormat:@"Two finger tap at index : %ld", (long)indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Gesture Alert" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:NO completion:nil];
}

- (void)doubleTap:(UITapGestureRecognizer *)sender {
    CGPoint touch = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touch];
    NSString *alertMessage = [NSString stringWithFormat:@"Double tap at index : %ld", (long)indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Gesture Alert" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:NO completion:nil];
}

- (void)longPress:(UITapGestureRecognizer *)sender {
    CGPoint touch = [sender locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:touch];
    NSString *alertMessage = [NSString stringWithFormat:@"Long press at index : %ld", (long)indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Gesture Alert" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:ok];
    [self presentViewController:alert animated:NO completion:nil];
}

@end
