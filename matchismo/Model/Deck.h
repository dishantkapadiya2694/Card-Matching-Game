//
//  Deck.h
//  matchismo
//
//  Created by Dishant Kapadiya on 7/14/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

-(void) addCard:(Card *)card atTop:(BOOL)atTop;
-(void) addCard:(Card *)card;
-(Card *)drawRandomCard;

@end
