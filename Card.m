//
//  Card.m
//  matchismo
//
//  Created by Dishant Kapadiya on 7/14/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards){
        if([card.contents isEqualToString:self.contents]){
            score = 10;
        }
    }
    return score;
}

@end
