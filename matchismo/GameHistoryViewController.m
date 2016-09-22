//
//  GameHistoryViewController.m
//  matchismo
//
//  Created by Dishant Kapadiya on 8/16/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "GameHistoryViewController.h"

@interface GameHistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *gameHistoryLabel;

@end

@implementation GameHistoryViewController

-(void)viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

-(void)updateUI
{
    self.gameHistoryLabel.text = self.gameHistory;
}

@end
