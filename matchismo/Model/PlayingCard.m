//
//  PlayingCard.m
//  matchismo
//
//  Created by Dishant Kapadiya on 7/14/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;



-(int)match:(NSArray *)otherCards
{
    int score = 0;
    NSMutableArray *cards = otherCards.mutableCopy;
    NSMutableSet *matchingCards = [[NSMutableSet alloc] init];
    [cards addObject:self];
    while([cards count]){
        PlayingCard *card = cards.lastObject;
        if ([card isMemberOfClass:[PlayingCard class]]){
            [cards removeObject:card];
            for (PlayingCard *otherCard in cards){
                if([otherCard isMemberOfClass:[PlayingCard class]]){
                    if([card.suit isEqualToString:otherCard.suit]){
                        score += 2;
                        [matchingCards addObject:card];
                        [matchingCards addObject:otherCard];
                    }
                    else if(card.rank == otherCard.rank){
                        score += 5;
                        [matchingCards addObject:card];
                        [matchingCards addObject:otherCard];
                    }
                }
            }
        }
    }
    return score;
}


-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

+(NSArray *)validSuits
{
    return @[@"♠︎",@"♣︎",@"♥︎",@"♦︎"];
}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}


+(NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
}


-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}

-(void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
        _rank=rank;
}

-(NSString *)suit
{
    return _suit ? _suit : @"?";
}
@end
