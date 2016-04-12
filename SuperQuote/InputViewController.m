//
//  InputViewController.m
//  SuperQuote
//
//  Created by Chen Jin on 3/19/15.
//  Copyright (c) 2015 Chen Jin. All rights reserved.
//

#import "InputViewController.h"
#import "QuoteModel.h"

@interface InputViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputQuoteLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputAuthorLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (strong, nonatomic)QuoteModel *model;
@end


@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _model = [QuoteModel sharedModel];
    self.saveButton.enabled = NO;
    
    
    [_inputQuoteLabel setDelegate: self];
    [_inputQuoteLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [_inputAuthorLabel setDelegate: self];
    [_inputAuthorLabel addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)textFieldDidChange:(UITextField *)textField {
    if ( (_inputQuoteLabel.text.length > 0) && (_inputAuthorLabel.text.length > 0) )
        [_saveButton setEnabled: YES];
    else
        [_saveButton setEnabled: NO];
}


- (BOOL) textFieldshouldReturn: (UITextField *) textField {
    if(self.completionHandler) {
        self.completionHandler(self.inputQuoteLabel.text, self.inputAuthorLabel.text);
    }
    return YES;
}

/*
- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *changedString = [textField.text stringByReplacingCharactersInRange:range withString:string];

    
    [self validateSaveButtonForText: changedString];
    return YES;
}

- (void) validateSaveButtonForText: (NSString *) text {
    //if ( (self.inputQuoteLabel.text.length > 0) && (self.inputAuthorLabel.text.length > 0) ) {
    //    self.saveButton.enabled = YES;
    //}
    
    self.saveButton.enabled = ([text length] > 0);
}*/


- (IBAction) cancelButtonTapped: (id)sender {
    if(self.completionHandler) {
        self.completionHandler(nil, nil);
    }
}

- (IBAction) saveButtonTapped:(id)sender {
    if(self.completionHandler) {
        self.completionHandler(self.inputQuoteLabel.text, self.inputAuthorLabel.text);
    }
}







@end
