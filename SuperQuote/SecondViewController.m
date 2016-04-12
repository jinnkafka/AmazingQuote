//
//  SecondViewController.m
//  SuperQuote
//
//  Created by Chen Jin on 3/18/15.
//  Copyright (c) 2015 Chen Jin. All rights reserved.
//

#import "SecondViewController.h"
#import "InputViewController.h"
#import "QuoteModel.h"
@interface SecondViewController ()
@property (strong, nonatomic)QuoteModel *model;
@end

@implementation SecondViewController

#pragma mark - View did load

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _model = [QuoteModel sharedModel];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id)sender {
    InputViewController *inputVC = segue.destinationViewController;
    inputVC.completionHandler = ^(NSString *quoteText, NSString *authorText) {
        if(quoteText != nil && authorText != nil) {
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                                  quoteText,@"quote",
                                  authorText, @"author",
                                  nil];
            [self.model insertQuote: dict atIndex:0];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_model numberOfQuotes];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableCell" forIndexPath:
                             indexPath];
    // Configure the cell...
    NSDictionary *quote = [_model quoteAtIndex:indexPath.row];
    cell.textLabel.text = quote[@"quote"];
    cell.detailTextLabel.text = quote[@"author"];

    return cell;
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 //[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 
 //delete from the model
     [_model removeQuoteAtIndex:indexPath.row];
 //delete the row from data source
     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
