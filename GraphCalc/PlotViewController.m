#import "PlotViewController.h"

@implementation PlotViewController

@synthesize plotView = _plotView;

-(double)valueWhenXEquals:(double)x
{
    
    NSDictionary *variableDict = 
    [NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:x] 
                                forKey:@"x"];  
    
    NSNumber *returnValue = [CalculatorBrain runProgram:_equation 
                                    usingVariableValues:variableDict];
    
    return [returnValue doubleValue];
    
}

- (void)drawEquation:(id)equation;
{
    NSLog(@"PlotViewController drawEquation:");
    
    _equation = equation;
    
    NSLog(@"%@",_equation);
    
    
    
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
