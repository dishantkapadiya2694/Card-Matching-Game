//
//  ViewController.h
//  matchismo
//
//  Created by Dishant Kapadiya on 7/14/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//
// Abstract class. Must implement methods as described below
#import <UIKit/UIKit.h>
#import "Deck.h"

@interface ViewController : UIViewController


//protected
//for subclasses
@property (nonatomic) NSUInteger numberOfCardsToBeMatched;
@property (strong, nonatomic) NSArray *Cards;


// abstract
-(Deck *)createDeck;
-(NSAttributedString *)titleForCard:(Card *)card;
-(UIImage *)backgroundImageForCard:(Card *)card;
-(void)setPropertiesForCard:(Card *)card;
@end

