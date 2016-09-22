//
//  CardMatchingGame.h
//  matchismo
//
//  Created by Dishant Kapadiya on 7/18/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
@interface CardMatchingGame : NSObject

//designated initializer
-(instancetype)initWithCardCount:(NSUInteger) count
                       usingDeck:(Deck *) deck
                        maxCards:(unsigned int) numberOfCards;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) unsigned int maxCardsToBeMatched;
@property (nonatomic, readonly) NSMutableArray *gameHistory;

@end
