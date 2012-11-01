#import <UIKit/UIKit.h>
#import "ExampleView.h"
#define P(x) [@"/Library/PreferenceBundles/BubblyMailPreferences.bundle" stringByAppendingPathComponent:x]
#define I(x) [UIImage imageWithContentsOfFile:x]
@interface PSEditingPane : UIView
{
    CGRect _pinstripeRect;
    UIView *_pinstripeView;
}
@property (nonatomic, assign) CGRect pinstripeRect;
@end
@interface TopColorPane : PSEditingPane
@property (nonatomic, retain) UISlider *redSlider;
@property (nonatomic, retain) UISlider *greenSlider;
@property (nonatomic, retain) UISlider *blueSlider;
@property (nonatomic, retain) UISlider *alphaSlider;
@property (nonatomic, retain) UISlider *redSlider2;
@property (nonatomic, retain) UISlider *greenSlider2;
@property (nonatomic, retain) UISlider *blueSlider2;
@property (nonatomic, retain) UISlider *alphaSlider2;
@property (nonatomic, retain) UIView *topView;
@property (nonatomic, retain) UIView *bottomView;
@property (nonatomic, retain) ExampleView *exampleView;
@property (nonatomic, retain) UIView *topExample;
@property (nonatomic, retain) UIView *bottomExample;
@property (nonatomic) float topRed;
@property (nonatomic) float topBlue;
@property (nonatomic) float topGreen;
@property (nonatomic) float topAlpha;
@property (nonatomic) float bottomRed;
@property (nonatomic) float bottomBlue;
@property (nonatomic) float bottomGreen;
@property (nonatomic) float bottomAlpha;
- (void)topRedChanged:(id)sender;
- (void)topBlueChanged:(id)sender;
- (void)topGreenChanged:(id)sender;
- (void)topAlphaChanged:(id)sender;
- (void)bottomRedChanged:(id)sender;
- (void)bottomBlueChanged:(id)sender;
- (void)bottomGreenChanged:(id)sender;
- (void)bottomAlphaChanged:(id)sender;
- (void)updateTopView;
- (void)updateBottomView;
- (void)updateExampleView;
@end
@implementation TopColorPane : PSEditingPane
@synthesize redSlider, greenSlider, blueSlider, alphaSlider, redSlider2, greenSlider2, blueSlider2, alphaSlider2, topView, bottomView, exampleView, topExample, bottomExample, topRed, topBlue, topGreen, topAlpha, bottomRed, bottomBlue, bottomGreen, bottomAlpha;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        topView = [[UIView alloc] initWithFrame:CGRectMake(10, 5, 300, 180)];
        [topView setBackgroundColor:[UIColor blackColor]];
        redSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 10, 260, 23)];
        [redSlider addTarget:self action:@selector(topRedChanged:) forControlEvents:UIControlEventValueChanged];
        [redSlider setMinimumValueImage:I(P(@"RedMinus@2x.png"))];
        [redSlider setMaximumValueImage:I(P(@"RedPlus@2x.png"))];
        [redSlider setMaximumValue:1.0];
        [redSlider setMinimumValue:0.0];
        [topView addSubview:redSlider];
        greenSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 43, 260, 23)];
        [greenSlider setMaximumValue:1.0];
        [greenSlider setMinimumValue:0.0];
        [greenSlider addTarget:self action:@selector(topGreenChanged:) forControlEvents:UIControlEventValueChanged];
        [greenSlider setMinimumValueImage:I(P(@"GreenMinus@2x.png"))];
        [greenSlider setMaximumValueImage:I(P(@"GreenPlus@2x.png"))];
        [topView addSubview:greenSlider];
        blueSlider = [[UISlider alloc] initWithFrame:CGRectMake(20,  76, 260, 23)];
        [blueSlider setMaximumValue:1.0];
        [blueSlider setMinimumValue:0.0];
        [blueSlider addTarget:self action:@selector(topBlueChanged:) forControlEvents:UIControlEventValueChanged];
        [blueSlider setMinimumValueImage:I(P(@"BlueMinus@2x.png"))];
        [blueSlider setMaximumValueImage:I(P(@"BluePlus@2x.png"))];
        [topView addSubview:blueSlider];
        alphaSlider = [[UISlider alloc] initWithFrame:CGRectMake(20, 109, 260, 23)];
        [alphaSlider setMaximumValue:1.0];
        [alphaSlider setMinimumValue:0.0];
        [alphaSlider addTarget:self action:@selector(topAlphaChanged:) forControlEvents:UIControlEventValueChanged];
        [topView addSubview:alphaSlider];
        topExample = [[UIView alloc] initWithFrame:CGRectMake(20, 142, 260, 23)];
        [topExample setBackgroundColor:[UIColor whiteColor]];
        [topView addSubview:topExample];
        [self addSubview:topView];
        
        exampleView = [[ExampleView alloc] initWithFrame:CGRectMake(40, 192.5, 230, 27.5)];
        [exampleView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:exampleView];
        bottomView = [[UIView alloc] initWithFrame:CGRectMake(10, 230, 300, 180)];
        [bottomView setBackgroundColor:[UIColor blackColor]];
        redSlider2 = [[UISlider alloc] initWithFrame:CGRectMake(20, 10, 260, 23)];
        [redSlider2 setMaximumValue:1.0];
        [redSlider2 setMinimumValue:0.0];
        [redSlider2 addTarget:self action:@selector(bottomRedChanged:) forControlEvents:UIControlEventValueChanged];
        [redSlider2 setMinimumValueImage:I(P(@"RedMinus@2x.png"))];
        [redSlider2 setMaximumValueImage:I(P(@"RedPlus@2x.png"))];
        [bottomView addSubview:redSlider2];
        greenSlider2 = [[UISlider alloc] initWithFrame:CGRectMake(20, 43, 260, 23)];
        [greenSlider2 setMaximumValue:1.0];
        [greenSlider2 setMinimumValue:0.0];
        [greenSlider2 addTarget:self action:@selector(bottomGreenChanged:) forControlEvents:UIControlEventValueChanged];
        [greenSlider2 setMinimumValueImage:I(P(@"GreenMinus@2x.png"))];
        [greenSlider2 setMaximumValueImage:I(P(@"GreenPlus@2x.png"))];
        [bottomView addSubview:greenSlider2];
        blueSlider2 = [[UISlider alloc] initWithFrame:CGRectMake(20,  76, 260, 23)];
        [blueSlider2 addTarget:self action:@selector(bottomBlueChanged:) forControlEvents:UIControlEventValueChanged];
        [blueSlider2 setMaximumValue:1.0];
        [blueSlider2 setMinimumValue:0.0];
        [blueSlider2 setMinimumValueImage:I(P(@"BlueMinus@2x.png"))];
        [blueSlider2 setMaximumValueImage:I(P(@"BluePlus@2x.png"))];
        [bottomView addSubview:blueSlider2];
        alphaSlider2 = [[UISlider alloc] initWithFrame:CGRectMake(20, 109, 260, 23)];
        [alphaSlider2 setMaximumValue:1.0];
        [alphaSlider2 setMinimumValue:0.0];
        [alphaSlider2 addTarget:self action:@selector(bottomAlphaChanged:) forControlEvents:UIControlEventValueChanged];
        [bottomView addSubview:alphaSlider2];
        bottomExample = [[UIView alloc] initWithFrame:CGRectMake(20, 142, 260, 23)];
        [bottomExample setBackgroundColor:[UIColor whiteColor]];
        [bottomView addSubview:bottomExample];
        [self addSubview:bottomView];
        
    }
    return self;
}
- (void)topRedChanged:(id)sender {
    topRed = [redSlider value];
    [self updateTopView];
}
- (void)topBlueChanged:(id)sender {
    topBlue = [blueSlider value];
    [self updateTopView];
}
- (void)topGreenChanged:(id)sender {
    topGreen = [greenSlider value];
    [self updateTopView];
}
- (void)topAlphaChanged:(id)sender {
    topAlpha = [alphaSlider value];
    [self updateTopView];
}
- (void)bottomRedChanged:(id)sender {
    bottomRed = [redSlider2 value];
    [self updateBottomView];
}
- (void)bottomBlueChanged:(id)sender {
    bottomBlue = [blueSlider2 value];
    [self updateBottomView];
}
- (void)bottomGreenChanged:(id)sender {
    bottomGreen = [greenSlider2 value];
    [self updateBottomView];
}
- (void)bottomAlphaChanged:(id)sender {
    bottomAlpha = [alphaSlider2 value];
    [self updateBottomView];
}
- (void)updateTopView {
    UIColor *topColor = [UIColor colorWithRed:topRed green:topGreen blue:topBlue alpha:topAlpha];
    [topExample setBackgroundColor:topColor];
    [topExample setNeedsDisplay];
    [self updateExampleView];
}
- (void)updateBottomView {
    UIColor *bottomColor = [UIColor colorWithRed:bottomRed green:bottomGreen blue:bottomBlue alpha:bottomAlpha];
    [bottomExample setBackgroundColor:bottomColor];
    [bottomExample setNeedsDisplay];
    [self updateExampleView];
}
- (void)updateExampleView {
    exampleView.topRed = topRed;
    exampleView.topGreen = topGreen;
    exampleView.topBlue = topBlue;
    exampleView.topAlpha = topAlpha;
    exampleView.bottomRed = bottomRed;
    exampleView.bottomGreen = bottomGreen;
    exampleView.bottomBlue = bottomBlue;
    exampleView.bottomAlpha = bottomAlpha;
    [exampleView setNeedsDisplay];
}
@end
