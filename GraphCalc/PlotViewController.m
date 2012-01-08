#import "PlotViewController.h"

@implementation PlotViewController

@synthesize plotView = _plotView;
@synthesize equationLabel = _equationLabel;
@synthesize equation = _equation;
@synthesize toolbar = _toolbar;

#pragma mark -
#pragma mark Plot View Data Source

-(double)valueWhenXEquals:(double)x
{
    
    NSDictionary *variableDict = 
    [NSDictionary dictionaryWithObject:[NSNumber numberWithDouble:x] 
                                forKey:@"x"];  
    
    id returnValue = [CalculatorBrain runProgram:_equation 
                             usingVariableValues:variableDict];
    
    //NSLog(@"%3.3f %3.3f",x,[returnValue doubleValue]);
    
    if ([returnValue isKindOfClass:[NSNumber class]])
        return [returnValue doubleValue];
    else
        return INFINITY;
    
}

#pragma mark -
#pragma mark Split View controller delegate

// Called when a button should be added to a toolbar for a hidden view 
// controller
- (void)splitViewController:(UISplitViewController*)svc 
     willHideViewController:(UIViewController *)aViewController 
          withBarButtonItem:(UIBarButtonItem*)barButtonItem 
       forPopoverController:(UIPopoverController*)pc
{
    
    NSLog(@"PlotViewController splitViewController: willHideViewController: \
          withBarButtonItem: forPopoverController:");
    
    barButtonItem.title = @"Calculator";
    
    self.toolbar.items = [NSArray arrayWithObject:barButtonItem];
    
}

// Called when the view is shown again in the split view, invalidating the 
// button and popover controller
- (void)splitViewController:(UISplitViewController*)svc 
     willShowViewController:(UIViewController *)aViewController 
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    NSLog(@"CalculatorViewController splitViewController: willShowViewController: \
          invalidatingBarButtonItem:");
    
    if ([self.toolbar.items lastObject])
        self.toolbar.items = nil;
}

// Returns YES if a view controller should be hidden by the split view 
// controller in a given orientation.
// (This method is only called on the leftmost view controller and only 
// discriminates portrait from landscape.)
- (BOOL)splitViewController:(UISplitViewController*)svc 
   shouldHideViewController:(UIViewController *)vc 
              inOrientation:(UIInterfaceOrientation)orientation  
{
    //return (UIInterfaceOrientationIsPortrait(orientation));
    return YES;
}

#pragma mark -
#pragma mark View lifecycle

- (void)awakeFromNib
{
    NSLog(@"PlotViewController awakeFromNib");
    
    [super awakeFromNib];
    
    if (self.splitViewController)
        self.splitViewController.delegate = self;
    

}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"PlotViewController viewWillAppear:");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([defaults objectForKey:@"scale"])  
    {
        double scale = [[defaults objectForKey:@"scale"] doubleValue];
        self.plotView.scale = scale;
    }
    
    if ([defaults objectForKey:@"origin.x"] && 
        [defaults objectForKey:@"origin.y"])
    {
        double ox = [[defaults objectForKey:@"origin.x"] doubleValue];
        double oy = [[defaults objectForKey:@"origin.y"] doubleValue];
        
        self.plotView.origin = CGPointMake(ox, oy);
    }
        
    self.equationLabel.text = 
    [CalculatorBrain descriptionOfProgram:self.equation];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    NSLog(@"PlotViewController viewWillDisappear");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSNumber numberWithDouble:self.plotView.scale] 
                 forKey:@"scale"];
 
    [defaults setObject:[NSNumber numberWithDouble:self.plotView.origin.x] 
                 forKey:@"origin.x"];
    [defaults setObject:[NSNumber numberWithDouble:self.plotView.origin.y] 
                 forKey:@"origin.y"];    

    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [super viewWillDisappear:animated];
}

- (void)viewDidUnload
{

    [self setEquationLabel:nil];
    _equation = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:
(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark Gesture recognizer handlers

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
    
    NSLog(@"PlotViewController pinch:");
  
    if ( (sender.state == UIGestureRecognizerStateEnded) || 
         (sender.state == UIGestureRecognizerStateChanged) )
    {
        self.plotView.scale*=sender.scale;
        
        sender.scale=1.0;        
    }
    
}

@end
