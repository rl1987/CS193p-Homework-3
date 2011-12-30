#import <UIKit/UIKit.h>

//#import "AxesDrawer.h"
#import "PlotView.h"
#import "CalculatorBrain.h" 

@interface PlotViewController : UIViewController <PlotViewDataSource>
{
}

@property (nonatomic,strong) IBOutlet PlotView *plotView;
@property (strong, nonatomic) IBOutlet UILabel *equationLabel;
@property (nonatomic,weak) NSArray *equation;

@end
