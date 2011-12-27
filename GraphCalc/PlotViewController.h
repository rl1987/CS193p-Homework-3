#import <UIKit/UIKit.h>

//#import "AxesDrawer.h"
#import "PlotView.h"
#import "CalculatorBrain.h" 

@interface PlotViewController : UIViewController <PlotViewDataSource>
{
    id _equation;
}

@property (nonatomic,strong) IBOutlet PlotView *plotView;


- (void)drawEquation:(id)equation;

@end
