//
//  Deck.m
//  matchismo
//
//  Created by Dishant Kapadiya on 7/14/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "Deck.h"

@interface Deck()

@property (nonatomic, strong) NSMutableArray *cards;

@end


@implementation Deck

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}


-(void) addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop)
        [self.cards insertObject:card atIndex:0];
    else
        [self.cards addObject:card];
}

-(void) addCard:(Card *)card
{
    [self addCard:card atTop:NO];
}

-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    
    if ([self.cards count])
    {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        // try this -> [self.cards removeObject:randomCard];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
    
}


@end
