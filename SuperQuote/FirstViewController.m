//
//  FirstViewController.m
//  SuperQuote
//
//  Created by Chen Jin on 3/18/15.
//  Copyright (c) 2015 Chen Jin. All rights reserved.
//

#import "FirstViewController.h"
#import "QuoteModel.h"
#import "FavoriteModel.h"
#import <AVFoundation/AVFoundation.h>

@interface FirstViewController ()
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;

@property (strong, nonatomic) QuoteModel *model;
@property (strong, nonatomic) FavoriteModel *fmodel;

@property (strong, nonatomic) AVAudioPlayer *audioPlayer;
@property (weak, nonatomic) IBOutlet UISwitch *soundSwitch;

@property (strong, nonatomic) NSString *sound;

@end

@implementation FirstViewController

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void) viewDidAppear:(BOOL)animated {
    [self becomeFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _model = [QuoteModel sharedModel];
    _fmodel = [FavoriteModel sharedModel];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    //print out the file path for quotes.plist on terminal
    NSLog(@"Documents Directory: %@", [[[NSFileManager
                                         defaultManager] URLsForDirectory:NSDocumentDirectory
                                        inDomains:NSUserDomainMask] lastObject]);
    
    //add the sound effect
    NSString *path = [NSString stringWithFormat: @"%@/Tada.wav",
                      [ [NSBundle mainBundle] resourcePath ]];
    NSURL *soundUrl = [NSURL fileURLWithPath:path];
    NSError *error;
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:&error];
    [self.audioPlayer prepareToPlay];
    
    
    
    //single tap gesture
    UITapGestureRecognizer *singleTap =
    [ [UITapGestureRecognizer alloc]
     initWithTarget:self action:@selector(singleTapRecognized:)];
    [self.view addGestureRecognizer:singleTap];
    
    //double tap gesture (add to favorite)
    UITapGestureRecognizer *doubleTap =
    [ [UITapGestureRecognizer alloc]
     initWithTarget:self action:@selector(doubleTapRecognized:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    //left swipe gesture
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc]
                                           initWithTarget:self action: @selector(leftSwipeRecognized: )];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:leftSwipe];
    
    //right swipe gesture
    UISwipeGestureRecognizer *rightSwipe = [[UISwipeGestureRecognizer alloc]
                                            initWithTarget:self action: @selector(rightSwipeRecognized: )];
    rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:rightSwipe];
}

- (void) leftSwipeRecognized: (UISwipeGestureRecognizer *) recognizer {
    //play sounds file
    if (self.soundSwitch.isOn){
        [self.audioPlayer play];
    }
    
    NSDictionary *prevQuote = [self.model prevQuote];
    self.quoteLabel.alpha = 0;
    self.authorLabel.alpha = 0;
    self.quoteLabel.text = prevQuote[@"quote"];
    self.authorLabel.text = prevQuote[@"author"];
    //change color (animation)
    if (self.quoteLabel.textColor == UIColor.blackColor) {
        self.quoteLabel.textColor = [
                                     UIColor colorWithRed:(153.0f/255.0f) green: 0.0
                                     blue: 0.0 alpha: 1.0
                                     ];
        self.authorLabel.textColor = [
                                      UIColor colorWithRed:(153.0f/255.0f) green: 0.0
                                      blue: 0.0 alpha: 1.0
                                      ];
    } else {
        self.quoteLabel.textColor = UIColor.blackColor;
        self.authorLabel.textColor = UIColor.blackColor;
    }
    //fade in and out (animation)
    [UIView animateWithDuration:1.5 animations:^{
        self.quoteLabel.alpha = 1;
        self.authorLabel.alpha = 1;
    }];
}

- (void) rightSwipeRecognized: (UISwipeGestureRecognizer *) recognizer {
    //play sounds file
    if (self.soundSwitch.isOn){
        [self.audioPlayer play];
    }
    
    NSDictionary *nextQuote = [self.model nextQuote];
    self.quoteLabel.alpha = 0;
    self.authorLabel.alpha = 0;
    self.quoteLabel.text = nextQuote[@"quote"];
    self.authorLabel.text = nextQuote[@"author"];
    //change color (animation)
    if (self.quoteLabel.textColor == UIColor.blackColor) {
        self.quoteLabel.textColor = [
                                     UIColor colorWithRed:(153.0f/255.0f) green: 0.0
                                     blue: 0.0 alpha: 1.0
                                     ];
        self.authorLabel.textColor = [
                                      UIColor colorWithRed:(153.0f/255.0f) green: 0.0
                                      blue: 0.0 alpha: 1.0
                                      ];
    } else {
        self.quoteLabel.textColor = UIColor.blackColor;
        self.authorLabel.textColor = UIColor.blackColor;
    }
    //fade in and out (animation)
    [UIView animateWithDuration:1.5 animations:^{
        self.quoteLabel.alpha = 1;
        self.authorLabel.alpha = 1;
    }];
}

- (void) singleTapRecognized: (UITapGestureRecognizer *) recognizer {
    //play sounds file
    if (self.soundSwitch.isOn){
        [self.audioPlayer play];
    }
    
    NSDictionary *randomQuote = [self.model randomQuote];
    self.quoteLabel.alpha = 0;
    self.authorLabel.alpha = 0;
    self.quoteLabel.text = randomQuote[@"quote"];
    self.authorLabel.text = randomQuote[@"author"];
    //change color (animation)
    if (self.quoteLabel.textColor == UIColor.blackColor) {
        self.quoteLabel.textColor = [
                                     UIColor colorWithRed:(153.0f/255.0f) green: 0.0
                                     blue: 0.0 alpha: 1.0
                                     ];
        self.authorLabel.textColor = [
                                      UIColor colorWithRed:(153.0f/255.0f) green: 0.0
                                      blue: 0.0 alpha: 1.0
                                      ];
    } else {
        self.quoteLabel.textColor = UIColor.blackColor;
        self.authorLabel.textColor = UIColor.blackColor;
    }
    //fade in and out (animation)
    [UIView animateWithDuration:1.5 animations:^{
        self.quoteLabel.alpha = 1;
        self.authorLabel.alpha = 1;
    }];
    
}

- (void) doubleTapRecognized: (UITapGestureRecognizer *) recognizer {
    //add the current quote to FavoriteModel
    
    if(_quoteLabel.text != nil && _authorLabel.text != nil) {
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              _quoteLabel.text,@"quote",
                              _authorLabel.text, @"author",
                              nil];
        
        
        [self.fmodel insertQuote: dict atIndex:0];
        //NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        //[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    //play sounds file
    if (self.soundSwitch.isOn){
        [self.audioPlayer play];
    }
    
    if (motion == UIEventSubtypeMotionShake) {
        NSDictionary *randomQuote = [self.model randomQuote];
        self.quoteLabel.alpha = 0;
        self.authorLabel.alpha = 0;
        self.quoteLabel.text = randomQuote[@"quote"];
        self.authorLabel.text = randomQuote[@"author"];
        //change color (animation)
        if (self.quoteLabel.textColor == UIColor.blackColor) {
            self.quoteLabel.textColor = [
                                         UIColor colorWithRed:(153.0f/255.0f) green: 0.0
                                         blue: 0.0 alpha: 1.0
                                         ];
            self.authorLabel.textColor = [
                                          UIColor colorWithRed:(153.0f/255.0f) green: 0.0
                                          blue: 0.0 alpha: 1.0
                                          ];
        } else {
            self.quoteLabel.textColor = UIColor.blackColor;
            self.authorLabel.textColor = UIColor.blackColor;
        }
        //fade in and out (animation)
        [UIView animateWithDuration:1.5 animations:^{
            self.quoteLabel.alpha = 1;
            self.authorLabel.alpha = 1;
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

