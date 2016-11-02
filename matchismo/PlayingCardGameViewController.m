//
//  PlayingCardGameViewController.m
//  matchismo
//
//  Created by Dishant Kapadiya on 8/3/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation PlayingCardGameViewController

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

-(void)viewDidLoad
{
    self.numberOfCardsToBeMatched = 2;
    self.Cards = self.cardButtons;
}

-(NSAttributedString *)titleForCard:(Card *)card
{
    if([card isKindOfClass:[PlayingCard class]]){
        NSString *str = card.isChosen?card.contents:@"";
        return [[NSAttributedString alloc] initWithString:str attributes:@{NSForegroundColorAttributeName: [UIColor blackColor]}];
    }
    return [[NSAttributedString alloc] initWithString:@""];
}

-(UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen? @"playingcardfront" : @"playingcardback"];
}

@end
