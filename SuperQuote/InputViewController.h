//
//  InputViewController.h
//  SuperQuote
//
//  Created by Chen Jin on 3/19/15.
//  Copyright (c) 2015 Chen Jin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InputCompletionHandler) (NSString *quoteText, NSString *authorText);

@interface InputViewController : UIViewController

@property (copy, nonatomic) InputCompletionHandler completionHandler;

@end
