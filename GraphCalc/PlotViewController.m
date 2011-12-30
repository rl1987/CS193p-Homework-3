#import "PlotViewController.h"

@implementation PlotViewController

@synthesize plotView = _plotView;

-(double)valueWhenXEquals:(double)x
{
    
    NSDictionary *variableDict = 
    [NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:x] 
                                forKey:@"x"];  
    
    id returnValue = [CalculatorBrain runProgram:_equation 
                             usingVariableValues:variableDict];
    
    if ([returnValue isKindOfClass:[NSNumber class]])
        return [returnValue doubleValue];
    else
        return NAN;
    
}

- (void)setEquation:(id)equation;
{
    NSLog(@"PlotViewController setEquation:");
    NSLog(@"%@",_equation);
    
    //_equation = equation;  
    _equation = [NSArray arrayWithObjects:@"x",@"sin",nil];
    
    self.plotView.dataSource = self;
    
    [self.plotView setNeedsDisplay];
    
}

#pragma mark - View lifecycle

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
