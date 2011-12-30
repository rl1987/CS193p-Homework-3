#import "PlotView.h"


@implementation PlotView

@synthesize dataSource = _dataSource;

@synthesize scale = _scale;
@synthesize origin = _origin;

- (void)setScale:(CGFloat)scale
{
    if (_scale == scale)
        return;
    
    _scale = scale;
    
    [self setNeedsDisplay];
    
}

- (void)setOrigin:(CGPoint)origin
{
    if ((_origin.x == origin.x) && (_origin.y == origin.y))
        return;
    
    _origin = origin;
    
    [self setNeedsDisplay];
}

#define INITIAL_SCALE 50.0

- (void)awakeFromNib
{
    self.scale = INITIAL_SCALE;
    self.bounds = self.frame;
    self.origin = self.center;
}

- (double)mappedXValueAtPoint:(int)point
{
    return (self.origin.x - (double)point)/self.scale;
}

- (int)pointForMappedYValue:(double)value
{
    return (int)(self.origin.y+rint(value*self.scale));
}

- (void)drawRect:(CGRect)rect
{
    if (!self.dataSource)
        return;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(context);
    
    [AxesDrawer drawAxesInRect:self.bounds 
                 originAtPoint:self.origin
                         scale:self.scale];
        
    // Graph drawing code. 
    
    enum {
        ON_THE_CHART,OFF_THE_CHART        
    } state;
        
    [[UIColor redColor] set];
    
    double value;
    
    state = OFF_THE_CHART;
    
    CGContextBeginPath(context);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    
    CGContextMoveToPoint(context, 0, self.origin.y);

    for (int x=0; x<self.bounds.size.width; x++)
    { // Two-state finite state machine is used to draw the curve.
        value=[self.dataSource valueWhenXEquals:[self mappedXValueAtPoint:x]];
        
        if ((value == NAN) ||
            ([self pointForMappedYValue:value]>self.bounds.size.height))
        {
            if (state == ON_THE_CHART)
            {
                CGContextClosePath(context);   
                CGContextStrokePath(context);
            }
            
            state = OFF_THE_CHART;
        }
        else
        {
            if (state == OFF_THE_CHART)
                CGContextBeginPath(context);
            else
                CGContextAddLineToPoint(context, x, 
                                        [self pointForMappedYValue:value]);
            
            CGContextMoveToPoint(context, (CGFloat)x, 
                                 [self pointForMappedYValue:value]);
            
            state = ON_THE_CHART;            
        }
        
    }
    
    CGContextStrokePath(context);
        
    UIGraphicsPopContext();        
}

@end
