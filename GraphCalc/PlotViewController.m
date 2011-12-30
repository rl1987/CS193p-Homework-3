#import "PlotViewController.h"

@implementation PlotViewController

@synthesize plotView = _plotView;
@synthesize equationLabel = _equationLabel;
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.equationLabel.text = 
    [CalculatorBrain descriptionOfProgram:self.equation];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self setEquationLabel:nil];
    _equation = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
