#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <Foundation/Foundation.h>
#import <CoreFoundation/CoreFoundation.h>
void drawLinearGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef  endColor) {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor, (id)endColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
}
CGMutablePathRef createRoundedRectForRect(CGRect rect, CGFloat radius) {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMaxX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMaxY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMaxY(rect), CGRectGetMinX(rect), CGRectGetMinY(rect), radius);
    CGPathAddArcToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetMaxX(rect), CGRectGetMinY(rect), radius);
    CGPathCloseSubpath(path);
    
    return path;        
}
void drawGlossAndGradient(CGContextRef context, CGRect rect, CGColorRef startColor, CGColorRef endColor) {
    
    drawLinearGradient(context, rect, startColor, endColor);
    
    CGColorRef glossColor1 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.35].CGColor;
    CGColorRef glossColor2 = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.1].CGColor;
    
    CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height/2);
    
    drawLinearGradient(context, topHalf, glossColor1, glossColor2);
    
}
@interface UnreadBubble : UIView
{
    BOOL _isSelected;
    unsigned int _unreadCount;
    CGSize _textSize;
}
- (id)initWithFrame:(CGRect)frame;
- (void)_sizeToFit;
- (void)setUnreadCount:(unsigned int)count;
- (void)setHighlighted:(BOOL)highlighted;
- (BOOL)isHighlighted;
- (void)setIsSelected:(BOOL)selected;
- (void)drawRect:(CGRect)rect;
@end

%hook UnreadBubble

- (void)drawRect:(CGRect)rect {
    if ([self.subviews count] != 0) {
    for (UILabel *l in self.subviews) {
        if ([l isKindOfClass:[UILabel class]]) {
            [l removeFromSuperview];
        }
    }
    }
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGColorRef topColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:0.75].CGColor;
    CGColorRef bottomColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.35 alpha:0.9].CGColor;
    
    
    
    CGFloat outerMargin = 2.0f;
    CGRect outerRect = CGRectInset(self.bounds, outerMargin, outerMargin);            
    CGMutablePathRef outerPath = createRoundedRectForRect(outerRect, 4.0);
    
    CGFloat innerMargin = 2.0f;
    CGRect innerRect = CGRectInset(outerRect, innerMargin, innerMargin);
    CGMutablePathRef innerPath = createRoundedRectForRect(innerRect, 4.0);
    

    CGContextAddPath(context, outerPath);
    CGContextClip(context);
    drawLinearGradient(context, outerRect, topColor, bottomColor);

    
    CALayer *bubbleLayer = self.layer;
    [bubbleLayer setMasksToBounds:NO];
    [bubbleLayer setShadowOffset:CGSizeMake(4.0,4.0)];
    [bubbleLayer setShadowColor:[UIColor blackColor].CGColor];
    [bubbleLayer setShadowOpacity:0.8];
    [bubbleLayer setShadowRadius:5.0];
    
    UILabel *l = [[UILabel alloc] initWithFrame:rect];
    [l setBackgroundColor:[UIColor clearColor]];
    [l setTextAlignment:UITextAlignmentCenter];
    [l setFont:[UIFont systemFontOfSize:14]];
    [l setTextColor:[UIColor whiteColor]];
    unsigned int unread = MSHookIvar<unsigned int>(self, "_unreadCount");
    NSString *s = [NSString stringWithFormat:@"%u", unread];
    [l setText:s];
    [self addSubview:l];
    [l release];
}
%end