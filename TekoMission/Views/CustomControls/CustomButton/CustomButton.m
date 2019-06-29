//
//  CustomButton.m
//  ProjectBase
//
//  Created by Eragon on 7/20/17.
//  Copyright © 2017 longtd. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

#if !TARGET_INTERFACE_BUILDER
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initBase];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initBase];
    }
    
    return self;
}
#endif

- (void)initBase {
    self.cornerRadius = 3.0;
    self.borderWidth = 0;
    self.borderColor = [UIColor blackColor];
    self.topCornerRadius = 0;
    self.bottomCornerRadius = 0;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}

- (void)setLeftToRight:(BOOL)leftToRight {
    _leftToRight = leftToRight;
    
    CGFloat scale = _leftToRight?1:-1;
    self.transform = CGAffineTransformMakeScale(scale, 1.);
    self.titleLabel.transform = CGAffineTransformMakeScale(scale, 1.);
    self.imageView.transform = CGAffineTransformMakeScale(scale, 1.);
}


- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
    [super setTitleColor:color forState:state];
    if (state == UIControlStateNormal) {
        [self setTitleColor:[self inverseColorFromColor:color] forState:UIControlStateHighlighted];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [self setTitleColor:[self reverseColorOf:[self titleColorForState:UIControlStateNormal]] forState:UIControlStateHighlighted];
    [super setHighlighted:highlighted];
}


// public methods
- (void)setImageAboveText {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGFloat totalHeight = imageSize.height + titleSize.height + 0;
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(-(totalHeight - imageSize.height), 0, 0, -titleSize.width)];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageSize.width, -(totalHeight - titleSize.height), 0)];
}


- (UIColor*)inverseColorFromColor:(UIColor*)color {
    CGFloat r,g,b,a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    return [UIColor colorWithRed:1.-r green:1.-g blue:1.-b alpha:a];
}

//====== TO GET THE OPPOSIT COLORS =====
-(UIColor *)reverseColorOf :(UIColor *)oldColor
{
    CGColorRef oldCGColor = oldColor.CGColor;
    
    int numberOfComponents = (int)CGColorGetNumberOfComponents(oldCGColor);
    // can not invert - the only component is the alpha
    if (numberOfComponents == 1) {
        return [UIColor colorWithCGColor:oldCGColor];
    }
    
    const CGFloat *oldComponentColors = CGColorGetComponents(oldCGColor);
    CGFloat newComponentColors[numberOfComponents];
    
    int i = numberOfComponents - 1;
    newComponentColors[i] = oldComponentColors[i]; // alpha
    while (--i >= 0) {
        newComponentColors[i] = 1 - oldComponentColors[i];
    }
    
    CGColorRef newCGColor = CGColorCreate(CGColorGetColorSpace(oldCGColor), newComponentColors);
    UIColor *newColor = [UIColor colorWithCGColor:newCGColor];
    CGColorRelease(newCGColor);
    
    //=====For the GRAY colors 'Middle level colors'
    CGFloat white = 0;
    [oldColor getWhite:&white alpha:nil];
    
    if(white>0.3 && white < 0.67)
    {
        if(white >= 0.5)
            newColor = [UIColor darkGrayColor];
        else if (white < 0.5)
            newColor = [UIColor blackColor];
        
    }
    return newColor;
}

- (void)prepareForInterfaceBuilder {
    [super prepareForInterfaceBuilder];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.topCornerRadius && self.bottomCornerRadius) {
        
    }
    
}

@end
