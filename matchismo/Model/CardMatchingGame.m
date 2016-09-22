//
//  CardMatchingGame.m
//  matchismo
//
//  Created by Dishant Kapadiya on 7/18/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "CardMatchingGame.h"
//#import "PlayingCard.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;  //array of cards
@property (nonatomic, strong) NSMutableArray *chosenCards;
@property (nonatomic, readwrite) unsigned int maxCardsToBeMatched;
@property (nonatomic, readwrite) NSMutableArray *gameHistory;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

-(NSMutableArray *)chosenCards
{
    if(!_chosenCards) _chosenCards = [[NSMutableArray alloc]init];
    return _chosenCards;
}

-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck maxCards:(unsigned int)numberOfCards
{
    self = [super init];
    if(self){
        for (int i=0;i<count;i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }
            else{
                self =nil;
                break;
            }
        }
        self.maxCardsToBeMatched = numberOfCards;
    }
    
    return self;
}

-(NSMutableArray *)gameHistory{
    if(!_gameHistory)
        _gameHistory = [[NSMutableArray alloc] init];
    return _gameHistory;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


-(NSString *)stringOfCardsUsing:(NSArray *)cards{
    NSMutableArray *arrayOfCardStrings = [[NSMutableArray alloc] init];
    for (Card *card in cards){
        [arrayOfCardStrings addObject:[NSString stringWithFormat:@"(%@)", card.contents]];
    }
    
    return [arrayOfCardStrings componentsJoinedByString:@" "];
}

-(void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card =  [self cardAtIndex:index];
    [self.gameHistory addObject:[NSString stringWithFormat:@"Chose %@", card.contents]];
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
            [self.chosenCards removeObject:card];
            [self.gameHistory addObject:@"Flipped last card back"];
        }
        else{
            if([self.chosenCards count] == self.maxCardsToBeMatched - 1){
                int matchScore = [card match:self.chosenCards];
                if(matchScore){
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for(Card *otherCard in self.chosenCards){
                        otherCard.matched = YES;
                    }
                    [self.gameHistory addObject:[NSString stringWithFormat:@"%@ matched! %d points", [self stringOfCardsUsing:[self.chosenCards arrayByAddingObjectsFromArray:@[card]]], (int)matchScore * MATCH_BONUS]];
                }
                else{
                    self.score -= MISMATCH_PENALTY;
                    [self.gameHistory addObject:[NSString stringWithFormat:@"%@ doesn't match! -%d points", [self stringOfCardsUsing:[self.chosenCards arrayByAddingObjectsFromArray:@[card]]], (int)MISMATCH_PENALTY]];
                }
                
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            if([self.chosenCards count] >= self.maxCardsToBeMatched-1)
                [self resetChosenCards];
            if(!card.isMatched){
                [self.chosenCards addObject:card];
            }
        }
    }
}

-(void)resetChosenCards{
    for(Card *otherCard in self.chosenCards){
        if (!otherCard.isMatched) {
            otherCard.chosen = NO;
        }
    }
    [self.chosenCards removeAllObjects];
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    if (index < [self.cards count])
        return self.cards[index];
    else
        return nil;
}

@end
