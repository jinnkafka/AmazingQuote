//
//  FavoriteModel.h
//  SuperQuote
//
//  Created by Chen Jin on 4/7/15.
//  Copyright (c) 2015 Chen Jin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FavoriteModel : NSObject

//private property
@property (strong, nonatomic) NSMutableArray *fQuotes;

@property NSUInteger currentIndex;

@property (strong, nonatomic) NSString *filepath;

+ (instancetype) sharedModel;


- (NSUInteger) numberOfQuotes;

- (NSDictionary *) quoteAtIndex: (NSUInteger) index;

- (void) removeQuoteAtIndex: (NSUInteger) index;

- (void) insertQuote: (NSDictionary *) quote
             atIndex: (NSUInteger) index;


@end
