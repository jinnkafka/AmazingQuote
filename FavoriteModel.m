//
//  FavoriteModel.m
//  SuperQuote
//
//  Created by Chen Jin on 4/7/15.
//  Copyright (c) 2015 Chen Jin. All rights reserved.
//

#import "FavoriteModel.h"

//class extension
@interface FavoriteModel ()





@end


@implementation FavoriteModel

+ (instancetype) sharedModel {
    static FavoriteModel * _sharedModel = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedModel = [[self alloc] init];
    });
    return _sharedModel;
}

- (instancetype)init {
    self = [super init];
    if(self) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        _filepath = [documentsDirectory stringByAppendingPathComponent:@"favorites.plist"];
        
        _fQuotes = [NSMutableArray arrayWithContentsOfFile:_filepath];
        
        if (!_fQuotes) {
            _fQuotes = [[NSMutableArray alloc] init];
        }
        
        _currentIndex = 0;
    }
    return self;
};

- (void) save {
    [self.fQuotes writeToFile: self.filepath atomically:YES];
}

- (NSUInteger) numberOfQuotes {
    return [self.fQuotes count];
}


- (NSDictionary *) quoteAtIndex:(NSUInteger) index {
    self.currentIndex = index;
    return [self.fQuotes objectAtIndex: index];
}

- (void) insertQuote:(NSDictionary *)quote atIndex:(NSUInteger) index {
    if (![_fQuotes containsObject:quote]) {
        if(index <= self.fQuotes.count) {
            self.currentIndex = index;
            [self.fQuotes insertObject:quote atIndex: index];
            //save the quote
            [self save];
        }
    }
}

- (void) removeQuoteAtIndex:(NSUInteger) index {
    if (index < self.fQuotes.count) {
        if (index == 0) {
            self.currentIndex = 0;
        }
        else {
            self.currentIndex = index - 1;
        }
        [self.fQuotes removeObjectAtIndex: index];
        [self save];
    }
}

@end




