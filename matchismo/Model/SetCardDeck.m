//
//  SetCardDeck.m
//  matchismo
//
//  Created by Dishant Kapadiya on 8/16/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

-(instancetype)init
{
    self = [super init];
    
    if(self)
    {
        for(NSString *symbol in [SetCard validSymbols]) {
            for(NSString *color in [SetCard validColors]){
                for(NSString *shading in [SetCard validShadings]){
                    for(NSUInteger count = 1; count <= [SetCard maxCount]; count++){
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                        card.count = count;
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}


@end
