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

#define INITIAL_SCALE 100.0

- (void)awakeFromNib
{
    self.scale = INITIAL_SCALE;
    self.origin = self.center;
    self.bounds = self.frame;
}

// Returns a value that a graphical point on a plot (either x or y) represents.
- (double)mappedValueAtPoint:(int)point
{
    return (double)point/self.scale;
}

- (int)pointForMappedValue:(double)value
{
    return (int)rint(value*self.scale);
}

- (void)drawRect:(CGRect)rect
{
    
    [AxesDrawer drawAxesInRect:self.bounds 
                 originAtPoint:self.origin
                         scale:self.scale];
    
    if (!self.dataSource)
        return;
    
    // Graph drawing code. 
    
    enum {
        ON_THE_CHART,OFF_THE_CHART        
    } state;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIGraphicsPushContext(context);
    
    [[UIColor redColor] set];
    
    //double *values = malloc(self.bounds.size.width*sizeof(double));
    double value;
    
    state = OFF_THE_CHART;
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, self.origin.y);
    
//    for (int x=0; x<self.bounds.size.width; x++)
//    {
//        CGContextAddLineToPoint(context,x,[self pointForMappedValue:value]);
//        
//        value=[self.dataSource valueWhenXEquals:[self mappedValueAtPoint:x]];
//        
//        CGContextMoveToPoint(context,(CGFloat)x,
//                             [self pointForMappedValue:value]);
//    }
        
    for (int x=0; x<self.bounds.size.width; x++)
    { // Two-state finite state machine is used to draw the curve.
        value=[self.dataSource valueWhenXEquals:[self mappedValueAtPoint:x]];
        
        if ([self pointForMappedValue:value]>self.bounds.size.height)
        {
            if (state == ON_THE_CHART)
                CGContextClosePath(context);                                
            
            state = OFF_THE_CHART;
        }
        else
        {
            if (state == OFF_THE_CHART)
                CGContextBeginPath(context);
            else
                CGContextAddLineToPoint(context, x, 
                                        [self pointForMappedValue:value]);
            
            CGContextMoveToPoint(context, (CGFloat)x, 
                                 [self pointForMappedValue:value]);
            
            state = ON_THE_CHART;            
        }
        
    }
    
    CGContextClosePath(context);
        
    UIGraphicsPopContext();        
}

@end
