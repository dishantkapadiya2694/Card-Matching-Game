//
//  SetCardView.h
//  SetCardView
//
//  Created by Dishant Kapadiya on 9/2/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetCardView : UIView

@property (nonatomic) NSUInteger count;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;
@property BOOL selected;

@end
