//
//  SetCardGameViewController.m
//  matchismo
//
//  Created by Dishant Kapadiya on 8/16/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"

@interface SetCardGameViewController()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardButtons;


@end

@implementation SetCardGameViewController

- (Deck *) createDeck {
    return [[SetCardDeck alloc] init];
}

-(void)viewDidLoad
{
    self.numberOfCardsToBeMatched = 3;
    self.Cards = self.cardButtons;
}







// New Code to draw the cards


-(void)setPropertiesForCard:(Card *)card {
    
}


// Code to draw card ends










-(NSAttributedString *)titleForCard:(Card *)card
{
    if(![card isKindOfClass:[SetCard class]])
        return nil;
    SetCard *setCard = (SetCard *)card;
    
    return [[NSAttributedString alloc] initWithString:[self symbolsToDisplayForCard:setCard] attributes:@{NSForegroundColorAttributeName:[self foregroundColorForCard:setCard],
                                                                                                          NSStrokeColorAttributeName: [self strokeColorForCard:setCard],
                                                                                                          NSStrokeWidthAttributeName: @-10}];
    
}



-(UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen? @"setcardfront" : @"setcardback"];
}


-(NSNumber *)getStrokeValueForCard:(SetCard *)card
{
    NSNumber *stroke = @0.0;
    
    return stroke;
}


-(CGFloat)getAlphaForCard:(SetCard *)card
{
    CGFloat alpha = 1.0;
    
    if([card.shading isEqualToString:@"transparent"])
        alpha = 0.0;
    if([card.shading isEqualToString:@"translucent"])
        alpha = 0.2;
    if([card.shading isEqualToString:@"solid"])
        alpha = 1.0;
    return alpha;
}

-(UIColor *)strokeColorForCard:(SetCard *)card
{
    if ([card.color isEqualToString:@"red"])
        return [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0];
    if ([card.color isEqualToString:@"green"])
        return [UIColor colorWithRed:0.0 green:1.0 blue:0.1 alpha:1.0];
    if ([card.color isEqualToString:@"purple"])
        return [UIColor colorWithRed:0.65 green:0.36 blue:0.96 alpha:1.0];
    return nil;
}

-(UIColor *)foregroundColorForCard:(SetCard *)card
{
    CGFloat alpha = [self getAlphaForCard:card];
    if ([card.color isEqualToString:@"red"])
        return [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:alpha];
    if ([card.color isEqualToString:@"green"])
        return [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:alpha];
    if ([card.color isEqualToString:@"purple"])
        return [UIColor colorWithRed:0.65 green:0.36 blue:0.96 alpha:alpha];
    return nil;
}

-(NSString *)symbolsToDisplayForCard:(SetCard*)card
{
    NSMutableArray *Arr = [[NSMutableArray alloc] init];
    for (int i=0 ; i < card.count ; i++)
    {
        [Arr addObject:card.symbol];
    }
    return [Arr componentsJoinedByString:@"\n"];
}












@end
