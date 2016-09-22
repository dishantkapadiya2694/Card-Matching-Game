//
//  ViewController.m
//  matchismo
//
//  Created by Dishant Kapadiya on 7/14/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCard.h"
#import "SetCard.h"
#import "CardMatchingGame.h"
#import "GameHistoryViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *scoreLabel;
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UITextView *commentryTextView;
@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"Show Game History"]){
        if([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]){
            GameHistoryViewController* ghvc = (GameHistoryViewController *)segue.destinationViewController;
            ghvc.gameHistory =  [self convertToString:self.game.gameHistory];
        }
    }
}

-(NSString *)convertToString:(NSMutableArray *)arr
{
    NSString *convertedString = [[NSString alloc] init];
    int count = 1;
    for(NSString *comment in arr){
        convertedString = [convertedString stringByAppendingString:[NSString stringWithFormat:@"%3d: %@\n",count,comment]];
        count++;
    }
    return convertedString;
}


-(CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.Cards count] usingDeck:[self createDeck] maxCards:(unsigned int) self.numberOfCardsToBeMatched];
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = (int)[self.Cards indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self updateUI];
}

-(void)updateCommentaryWithPoints{
    self.commentryTextView.text = [self.commentryTextView.text stringByAppendingString:[self.game.gameHistory lastObject]];
}

-(void)updateUI{
    for (UIButton *cardButton in self.Cards){
        NSUInteger cardIndex = [self.Cards indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.title = [NSString stringWithFormat:@"Score: %d",(int)self.game.score];
    }
    [self updateCommentaryWithPoints];
}

-(NSString *)titleForCard:(Card *)card {
    //abstract
    return nil;
}

-(UIImage *)backgroundImageForCard:(Card *)card {
    if ([card isKindOfClass:[SetCard class]])
        return [UIImage imageNamed:card.isChosen? @"setcardfront" : @"setcardback"];
    else if([card isKindOfClass:[PlayingCard class]])
        return [UIImage imageNamed:card.isChosen? @"playingcardfront" : @"playingcardback"];
    else
        return nil;
}

-(Deck *)createDeck
{
    // abstract
    return nil;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Yes"]) {
        self.game = nil;
        /*
        for (UIButton *cardButton in self.Cards){
            NSUInteger index = [self.Cards indexOfObject:cardButton];
            Card *card = [self.game cardAtIndex:index];
            [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
            [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
            cardButton.enabled = YES;
        }
         */
        id garbage = self.game;
        [self updateUI];
        self.scoreLabel.title = @"Score: 0";
    }
}

- (IBAction)redealGameButton:(UIButton *)sender {
    UIAlertView *redealAlert = [[UIAlertView alloc] initWithTitle:@"Attention!" message:@"Re-Deal will earse this game and all the progress in it.\n Are you sure you want to proceed?" delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No", nil];
    [redealAlert show];
}

@end
