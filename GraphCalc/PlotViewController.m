#import "PlotViewController.h"

@implementation PlotViewController

@synthesize plotView = _plotView;
@synthesize equation = _equation;

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

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    _equation = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
