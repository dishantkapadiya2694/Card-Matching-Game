//
//  SetCard.m
//  matchismo
//
//  Created by Dishant Kapadiya on 8/16/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()

@end

@implementation SetCard

@synthesize symbol = _symbol, color = _color, shading = _shading;

-(NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

-(void)setSymbol:(NSString *)symbol
{
    _symbol = [[SetCard validSymbols] containsObject:symbol] ? symbol : _symbol;
}

-(NSString *)shading
{
    return _shading ? _shading : @"?";
}

-(void)setShading:(NSString *)shading
{
    _shading = [[SetCard validShadings] containsObject:shading] ? shading : _shading;
}

-(NSString *)color
{
    return _color ? _color : @"?";
}

-(void)setColor:(NSString *)color
{
    _color = [[SetCard validColors] containsObject:color] ? color : _color;
}

-(NSString *)contents
{
    return [NSString stringWithFormat:@"%@|%@|%@|%tu", self.symbol, self.color, self.shading, self.count];
}

+(NSArray *)validSymbols
{
    return @[@"▲", @"●", @"◼︎"];
}

+(NSArray *)validColors
{
    return @[@"red", @"green", @"purple"];
}

+(NSArray *)validShadings
{
    return @[@"transparent", @"translucent", @"solid"];
}

-(void)setRank:(NSUInteger)count
{
    if(count > 0 && count <= 3){
        _count = count;
    }
}

+(NSUInteger)maxCount
{
    return 3;
}

-(int)match:(NSArray *)otherCards
{
    int score = 0;

    if(!([otherCards[0] isKindOfClass:[SetCard class]] && [otherCards[1] isKindOfClass:[SetCard class]])){
        return 0;
    }
    SetCard *card1 = self;
    SetCard *card2 = otherCards[0];
    SetCard *card3 = otherCards[1];
    Boolean count = [self doesItMatch:card1.count with:card2.count and:card3.count];
    Boolean symbols = [self doesItMatch:card1.symbol arg1:card2.symbol arg2:card3.symbol];
    Boolean color = [self doesItMatch:card1.color arg1:card2.color arg2:card3.color];
    Boolean shading = [self doesItMatch:card1.shading arg1:card2.shading arg2:card3.shading];
    
    if (count && symbols && color && shading){
        score = 20;
        card1.matched = YES;
        card2.matched = YES;
        card3.matched = YES;
    }
    
    return score;
}


-(Boolean) doesItMatch:(NSUInteger)a with:(NSUInteger)b and:(NSUInteger) c
{
    Boolean answer = NO;
    
    if((a == b && a == c) || (a != b && b != c))
        answer = YES;
    
    return answer;
}


-(Boolean) doesItMatch:(NSString *)str1 arg1:(NSString *)str2 arg2:(NSString *)str3
{
    Boolean answer = NO;
    
    if([str1 isEqualToString:str2] && [str2 isEqualToString:str3])
        answer = YES;
    if(!([str1 isEqualToString:str2]) && !([str2 isEqualToString:str3]))
        answer = YES;
    
    return answer;
}

@end
