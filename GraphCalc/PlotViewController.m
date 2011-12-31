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

- (IBAction)tripleTap:(UITapGestureRecognizer *)sender 
{
    
    if (sender.state != UIGestureRecognizerStateEnded)
        return;
        
    self.plotView.origin = [sender locationInView:self.plotView];
    
}

- (IBAction)pan:(UIPanGestureRecognizer *)sender 
{

    if ( (sender.state == UIGestureRecognizerStateEnded) || 
         (sender.state == UIGestureRecognizerStateChanged) )
    {
        CGPoint translation = [sender translationInView:self.view];
        
        self.plotView.origin = 
        CGPointMake(self.plotView.origin.x+translation.x, 
                    self.plotView.origin.y+translation.y);
        
        [sender setTranslation:CGPointZero inView:self.plotView];
    }
  
}

- (IBAction)pinch:(UIPinchGestureRecognizer *)sender 
{
  
    if ( (sender.state == UIGestureRecognizerStateEnded) || 
         (sender.state == UIGestureRecognizerStateChanged) )
    {
        self.plotView.scale*=sender.scale;
        
        sender.scale=1.0;        
    }
    
}

@end
