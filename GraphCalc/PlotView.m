#import "PlotView.h"


@implementation PlotView

@synthesize dataSource = _dataSource;

@synthesize scale = _scale;
@synthesize origin = _origin;

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    // Redraw graph.
    
}

- (void)setOrigin:(CGPoint)origin
{
    _origin = origin;
    
    // Redraw graph.
}

#define INITIAL_SCALE 100.0

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scale = INITIAL_SCALE;
        self.origin = frame.origin;
//        self.origin = CGPointMake(self.bounds.origin.x+self.bounds.size.width/2.0, 
//                                  self.bounds.origin.y+self.bounds.size.height/2.0);
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    [AxesDrawer drawAxesInRect:self.frame 
                 originAtPoint:self.frame.origin
                         scale:10.0];
}

@end
