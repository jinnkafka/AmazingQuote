//
//  QuoteModel.h
//  SuperQuote
//
//  Created by Chen Jin on 3/19/15.
//  Copyright (c) 2015 Chen Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuoteModel : NSObject

+ (instancetype) sharedModel;

- (NSDictionary *) randomQuote;

- (NSUInteger) numberOfQuotes;

- (NSDictionary *) quoteAtIndex: (NSUInteger) index;

- (void) removeQuoteAtIndex: (NSUInteger) index;

- (void) insertQuote: (NSDictionary *) quote
             atIndex: (NSUInteger) index;

- (NSDictionary *) nextQuote;

- (NSDictionary *) prevQuote;

@end
