//
//  QuoteModel.m
//  SuperQuote
//
//  Created by Chen Jin on 3/19/15.
//  Copyright (c) 2015 Chen Jin. All rights reserved.
//

#import "QuoteModel.h"

//class extension
@interface QuoteModel ()

//private property
@property (strong, nonatomic) NSMutableArray *quotes;

@property NSUInteger currentIndex;

@property (strong, nonatomic) NSString *filepath;



@end

@implementation QuoteModel

+ (instancetype) sharedModel {
    static QuoteModel * _sharedModel = nil;
    
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
        
        _filepath = [documentsDirectory stringByAppendingPathComponent:@"quotes.plist"];
        
        _quotes = [NSMutableArray arrayWithContentsOfFile:_filepath];
        
        if (!_quotes) {
            _quotes = [[NSMutableArray alloc] initWithObjects:
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"Whatever you do will be insignificant, but it is very important that you do it.",@"quote",
                        @"Mahatma Gandhi", @"author",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"A business that makes nothing but money is a poor business.",@"quote",
                        @"Henry Ford", @"author",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"Innovation has nothing to do with how many R&D dollars you have. It's about the people you have, how you're led, and how much you get it.",@"quote",
                        @"Steve Jobs", @"author",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"Experience is the teacher of all things.",@"quote",
                        @"Julius Caesar", @"author",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"When a woman is talking to you, listen to what she says with her eyes.",@"quote",
                        @"Victor Hugo", @"author",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"For what shall it profit a man, if he shall gain the whole world, and lose his own soul?",@"quote",
                        @"Jesus Christ", @"author",
                        nil],
                       [NSDictionary dictionaryWithObjectsAndKeys:
                        @"Your most unhappy customers are your greatest source of learning.",@"quote",
                        @"Bill Gates", @"author",
                        nil],
                       nil];
            
        }
        _currentIndex = 0;
    }
    return self;
}

- (void) save {
    [self.quotes writeToFile: self.filepath atomically:YES];
}

- (NSUInteger) numberOfQuotes {
    return [self.quotes count];
}

- (NSDictionary *) randomQuote {
    NSUInteger num = random() % [self numberOfQuotes];
    self.currentIndex = num;
    return self.quotes[num];
}

- (NSDictionary *) quoteAtIndex:(NSUInteger) index {
    self.currentIndex = index;
    return [self.quotes objectAtIndex: index];
}

- (void) insertQuote:(NSDictionary *)quote atIndex:(NSUInteger) index {
    if(index <= self.quotes.count) {
        self.currentIndex = index;
        [self.quotes insertObject:quote atIndex: index];
        //save the quote
        [self save];
    }
}

- (void) removeQuoteAtIndex:(NSUInteger) index {
    if (index < self.quotes.count) {
        if (index == 0) {
            self.currentIndex = 0;
        }
        else {
            self.currentIndex = index - 1;
        }
        [self.quotes removeObjectAtIndex: index];
        [self save];
    }
}

- (NSDictionary *) nextQuote {
    if (self.currentIndex == self.quotes.count-1) {
        _currentIndex = 0;
    }
    else {
        _currentIndex = self.currentIndex + 1;
    }
    return [self.quotes objectAtIndex: _currentIndex];
}

- (NSDictionary *) prevQuote {
    if (self.currentIndex == 0) {
        _currentIndex = self.quotes.count - 1;
    }
    else {
        _currentIndex = self.currentIndex - 1;
    }
    return [self.quotes objectAtIndex: _currentIndex];
}

@end

