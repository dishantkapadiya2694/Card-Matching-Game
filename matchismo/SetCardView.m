//
//  SetCardView.m
//  SetCardView
//
//  Created by Dishant Kapadiya on 9/2/16.
//  Copyright © 2016 Dishant Kapadiya. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView()

@end

@implementation SetCardView


#pragma mark Initialization

-(void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

-(void)awakeFromNib
{
    [self setup];
}

#pragma mark Properties
-(void)setColor:(NSString *)color
{
    _color = color;
    [self setNeedsDisplay];
}

-(void)setCount:(NSUInteger)count
{
    _count = count;
    [self setNeedsDisplay];
}

-(void)setShading:(NSString *)shading
{
    _shading = shading;
    [self setNeedsDisplay];
}

-(void)setSymbol:(NSString *)symbol
{
    _symbol = symbol;
    [self setNeedsDisplay];
}

-(void)setSelected:(BOOL)selected
{
    _selected = selected;
    [self setNeedsDisplay];
}

#pragma mark Drawing

#define CORNER_RADIUS 0.1
static const CGFloat CARD_WIDTH = 250;
static const CGFloat CARD_HEIGHT = 358;
static const CGFloat SYMBOL_WIDTH = 130;
static const CGFloat SYMBOL_HEIGHT = 70;

-(CGFloat)scalingFactor
{
    return self.bounds.size.width/CARD_WIDTH;
}

-(CGFloat)dy
{
    return self.bounds.size.height / 4;
}

-(void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.bounds.size.width * CORNER_RADIUS];
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    if(self.selected) {
        [[UIColor cyanColor] setStroke];
        roundedRect.lineWidth *= 3.0;
    } else {
        [[UIColor grayColor] setStroke];
        roundedRect.lineWidth *= 3.0;
    }
    [roundedRect stroke];
    [self drawSymbols];
    //[self drawSqiuggleAtPoint:@[[NSValue valueWithCGPoint:CGPointMake([self centerOfCard].x - [self sizeOfSymbol].width / 2, [self centerOfCard].y - [self sizeOfSymbol].height / 2)]] ofSize:[self sizeOfSymbol]];
}


-(void)drawSymbols
{
    if([self.symbol isEqualToString:@"oval"])
    {
        [self drawOvalAtPoint:[self locationsForSymbol] ofSize:[self sizeOfSymbol]];
    }
    
    else if([self.symbol isEqualToString:@"diamond"])
    {
        [self drawDiamondAtPoint:[self locationsForSymbol] ofSize:[self sizeOfSymbol]];
    }
    
    else if([self.symbol isEqualToString:@"sqiuggle"])
    {
        [self drawSqiuggleAtPoint:[self locationsForSymbol] ofSize:[self sizeOfSymbol]];
    }
}

-(UIColor *)colorForSymbol
{
    if([self.color isEqualToString:@"red"])
        return [UIColor redColor];
    else if([self.color isEqualToString:@"green"])
        return [UIColor greenColor];
    else if([self.color isEqualToString:@"purple"])
        return [UIColor purpleColor];
    else return [UIColor clearColor];
}

#define STROKE_WIDTH 3.0

-(void)drawOvalAtPoint:(NSArray *)points  ofSize:(CGSize) size
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for(NSValue *temp in points){
        CGPoint point = [temp CGPointValue];
        CGRect frameAroundOval = CGRectMake(point.x, point.y, size.width, size.height);

        UIRectFill(frameAroundOval);
        CGFloat radius = frameAroundOval.size.height / 2;
        [path moveToPoint:CGPointMake(point.x+radius, point.y)];
        [path addArcWithCenter:CGPointMake(point.x + radius, point.y + radius) radius:radius startAngle:-M_PI_2 endAngle:M_PI_2 clockwise:NO];
        [path addLineToPoint:CGPointMake(point.x + size.width - radius, point.y + size.height)];
        [path addArcWithCenter:CGPointMake(point.x + size.width - radius, point.y + radius) radius:radius startAngle:M_PI_2 endAngle:-M_PI_2 clockwise:NO];
        [path addLineToPoint:CGPointMake(point.x + radius, point.y)];
        [path closePath];
        
    }
    [[self colorForSymbol] setStroke];
    [path setLineWidth: STROKE_WIDTH * [self scalingFactor]];
    [path stroke];
    [self shadePath:path];
}

-(void)drawDiamondAtPoint:(NSArray *)points ofSize:(CGSize)size
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for(NSValue *temp in points)
    {
        CGPoint point = [temp CGPointValue];
        [path moveToPoint:CGPointMake(point.x, point.y + size.height / 2)];
        [path addLineToPoint:CGPointMake(point.x + size.width / 2 , point.y)];
        [path addLineToPoint:CGPointMake(point.x + size.width, point.y + size.height / 2)];
        [path addLineToPoint:CGPointMake(point.x + size.width / 2, point.y + size.height)];
        [path closePath];
    }
    [[self colorForSymbol] setStroke];
    [path setLineWidth: STROKE_WIDTH * [self scalingFactor]];
    [path stroke];
    [self shadePath:path];
}

#define SQUIGGLE_HEIGHT_FACTOR 9

-(void)drawSqiuggleAtPoint:(NSArray *)points ofSize:(CGSize)size
{
    UIBezierPath *path = [[UIBezierPath alloc] init];
    for(NSValue *temp in points)
    {
        CGPoint point = [temp CGPointValue];
        [path moveToPoint:point];
        [path addQuadCurveToPoint:CGPointMake(point.x + size.width / 2, point.y + size.height / SQUIGGLE_HEIGHT_FACTOR)
                     controlPoint:CGPointMake(point.x, point.y + size.height / SQUIGGLE_HEIGHT_FACTOR)];
        [path addQuadCurveToPoint:CGPointMake(point.x + size.width, point.y + size.height)
                     controlPoint:CGPointMake(point.x + size.width, point.y + size.height / SQUIGGLE_HEIGHT_FACTOR)];
        [path addQuadCurveToPoint:CGPointMake(point.x + size.width / 2, point.y +size.height / SQUIGGLE_HEIGHT_FACTOR * (SQUIGGLE_HEIGHT_FACTOR - 1))
                     controlPoint:CGPointMake(point.x + size.width, point.y + size.height / SQUIGGLE_HEIGHT_FACTOR * (SQUIGGLE_HEIGHT_FACTOR - 1))];
        [path addQuadCurveToPoint:point
                     controlPoint:CGPointMake(point.x, point.y + size.height / SQUIGGLE_HEIGHT_FACTOR * (SQUIGGLE_HEIGHT_FACTOR - 1))];
        [path closePath];
    }
    [[self colorForSymbol] setStroke];
    [path setLineWidth: STROKE_WIDTH * [self scalingFactor]];
    [path stroke];
    [self shadePath:path];
}

-(void)shadePath:(UIBezierPath *)path
{
    if([self.shading isEqualToString:@"transparent"])
    {
        [[UIColor clearColor] setFill];
        [path fill];
    }
    else if([self.shading isEqualToString:@"stripped"])
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGRect frameForStripes = [path bounds];
        UIBezierPath *stripes = [[UIBezierPath alloc]init];
        for(CGFloat i = 0 ; i < frameForStripes.size.width ; i += 15 * [self scalingFactor])
        {
            [stripes moveToPoint:CGPointMake(frameForStripes.origin.x + i, frameForStripes.origin.y)];
            [stripes addLineToPoint:CGPointMake(frameForStripes.origin.x + i, frameForStripes.origin.y + frameForStripes.size.height)];
        }
        UIGraphicsPushContext(ctx);
        [path addClip];
        [path setLineWidth: STROKE_WIDTH * [self scalingFactor]];
        [stripes stroke];
        UIGraphicsPopContext();
    }
    else if([self.shading isEqualToString:@"solid"])
    {
        [[self colorForSymbol] setFill];
        [path fill];
    }
}


-(CGSize)sizeOfSymbol
{
    return CGSizeMake(SYMBOL_WIDTH * [self scalingFactor], SYMBOL_HEIGHT * [self scalingFactor]);
}

-(CGPoint)centerOfCard
{
    CGPoint pnt;
    pnt.x = self.bounds.size.width / 2;
    pnt.y = self.bounds.size.height / 2;
    return pnt;
}

-(NSArray *)locationsForSymbol
{
    CGFloat dx = [self sizeOfSymbol].width / 2;
    CGFloat dy = [self sizeOfSymbol].height / 2;
    
    switch(self.count){
        case 1:
            return @[[NSValue valueWithCGPoint:CGPointMake([self centerOfCard].x - dx, [self centerOfCard].y - dy)]];
            break;
        case 2:
            return @[[NSValue valueWithCGPoint:CGPointMake([self centerOfCard].x - dx, [self centerOfCard].y + [self dy] - dy)],
                     [NSValue valueWithCGPoint:CGPointMake([self centerOfCard].x - dx, [self centerOfCard].y - [self dy] - dy)]];
        case 3:
            return @[[NSValue valueWithCGPoint:CGPointMake([self centerOfCard].x - dx, [self centerOfCard].y + [self dy] - dy)],
                     [NSValue valueWithCGPoint:CGPointMake([self centerOfCard].x - dx, [self centerOfCard].y - dy)],
                     [NSValue valueWithCGPoint:CGPointMake([self centerOfCard].x - dx, [self centerOfCard].y - [self dy] - dy)]];
        default:
            return @[];
    }
}


#pragma mark Gesture Recognition

-(void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded)) {
        CGAffineTransform transform = CGAffineTransformMakeScale(gesture.scale, gesture.scale);
        self.bounds = CGRectApplyAffineTransform(self.bounds, transform);
        gesture.scale = 1.0;
    }
}

@end
