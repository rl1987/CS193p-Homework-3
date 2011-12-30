#import <UIKit/UIKit.h>

//#import "AxesDrawer.h"
#import "PlotView.h"
#import "CalculatorBrain.h" 

@interface PlotViewController : UIViewController <PlotViewDataSource>
{
}

@property (nonatomic,strong) IBOutlet PlotView *plotView;
@property (nonatomic,weak) NSArray *equation;

- (void)setEquation:(NSArray *)equation;

@end
