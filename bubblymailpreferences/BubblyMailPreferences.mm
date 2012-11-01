#import <UIKit/UIKit.h>
@interface PSListController
{
    NSArray *_specifiers;
}
- (id)propertyForKey:(id)key;
- (void)setProperty:(id)property forKey:(id)key;
- (id)name;
- (id)values;
- (id)properties;
@end
@interface BubblyMailPreferencesListController: PSListController
{
    NSNumber *_topRed;
    NSNumber *_topGreen;
    NSNumber *_topBlue;
    NSNumber *_topAlpha;
    
    NSNumber *_bottomRed;
    NSNumber *_bottomGreen;
    NSNumber *_bottomBlue;
    NSNumber *_bottomAlpha;
}
@property (nonatomic, retain) NSNumber *topRed;
@property (nonatomic, retain) NSNumber *topGreen;
@property (nonatomic, retain) NSNumber *topBlue;
@property (nonatomic, retain) NSNumber *topAlpha;
@property (nonatomic, retain) NSNumber *bottomRed;
@property (nonatomic, retain) NSNumber *bottomGreen;
@property (nonatomic, retain) NSNumber *bottomBlue;
@property (nonatomic, retain) NSNumber *bottomAlpha;
- (id)specifiers;
@end

@implementation BubblyMailPreferencesListController
@synthesize topRed, topBlue, topGreen, topAlpha, bottomAlpha, bottomBlue, bottomGreen, bottomRed;
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"BubblyMailPreferences" target:self] retain];
	}
	return _specifiers;
}
- (void)setTopRedValue:(NSNumber *)val specifier:(id)specifier {
    topRed = val;
}
- (void)setTopGreenValue:(NSNumber *)val specifier:(id)specifier {
    topGreen = val;
}
- (void)setTopBlueValue:(NSNumber *)val specifier:(id)specifier {
    topBlue = val;
}
- (void)setTopAlphaValue:(NSNumber *)val specifier:(id)specifier {
    topAlpha = val;
}
- (void)setBottomRedValue:(NSNumber *)val specifier:(id)specifier {
    bottomRed = val;
}
- (void)setBottomGreenValue:(NSNumber *)val specifier:(id)specifier {
    bottomGreen = val;
}
- (void)setBottomBlueValue:(NSNumber *)val specifier:(id)specifier {
    bottomBlue = val;
}
- (void)setBottomAlphaValue:(NSNumber *)val specifier:(id)specifier {
    bottomAlpha = val;
}
@end

// vim:ft=objc
