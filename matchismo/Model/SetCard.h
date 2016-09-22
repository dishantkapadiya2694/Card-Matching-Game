//
//  SetCard.h
//  matchismo
//
//  Created by Dishant Kapadiya on 8/16/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger count;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;


+(NSArray *)validSymbols;
+(NSArray *)validColors;
+(NSArray *)validShadings;
+(NSUInteger)maxCount;

@end
