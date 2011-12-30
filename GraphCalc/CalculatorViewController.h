#import <UIKit/UIKit.h>

#import "PlotViewController.h"

@interface CalculatorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *auxillaryDisplay;

@property (strong, nonatomic) NSMutableDictionary *testVariableValues;

@end
