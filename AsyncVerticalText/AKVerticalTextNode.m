//
//  AKVerticalTextNode.m
//  AsyncVerticalText
//
//  Created by Kent on 11/20/15.
//  Copyright © 2015 Kent. All rights reserved.
//

#import "AKVerticalTextNode.h"
#import <CoreText/CoreText.h>
#import "AKVerticalTextRenderer.h"
#import "AKVerticalTextDrawingParameter.h"

@interface AKVerticalTextNode ()
@property (nonatomic, readonly) AKVerticalTextRenderer * render;
@property (atomic, assign) BOOL needsUpdateAttributeString;
@property (atomic, assign) BOOL needsUpdateFrameSetter;
@end

@implementation AKVerticalTextNode{

//    AKVerticalTextRenderer * _render;
    
}
@synthesize render = _render, font = _font;

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(AKVerticalTextRenderer *)render{

    if (!_render) {
        _render = [[AKVerticalTextRenderer alloc] initWithAttributedText:self.attributedText size:self.bounds.size];
    }
    return _render;
}

-(void)updateAttributedString{
    
    if (!_text) {
        _attributedText = nil;
        //        [self setNeedsDisplay];
        return;
    }
    
    NSMutableAttributedString * attributed = [[NSMutableAttributedString alloc] initWithString:_text attributes:nil];
    
    //    CTParagraphStyleSetting settings[1];
    //    CTParagraphStyleSetting setting;
    //    setting.spec = kCTParagraphStyleSpecifierMinimumLineHeight;
    //    CGFloat height = 28.0;
    //    setting.valueSize = sizeof(height);
    //    setting.value = &height;
    //    settings[0] = setting;
    //
    //    CTParagraphStyleRef style = CTParagraphStyleCreate(settings, 1);
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.minimumLineHeight = self.minimumLineHeight;
    
    [attributed addAttributes:@{NSFontAttributeName:self.font, //吐血, 用 systemFont 就会排版出错
                                NSVerticalGlyphFormAttributeName:@(YES),
                                NSParagraphStyleAttributeName:style} range:NSMakeRange(0, attributed.length)];
    
    for (id<WTAttributedStringLink> link in _links) {
        [attributed addAttribute:@"MyURLAttribute" value:link.link range:link.range];
    }
    _attributedText = attributed;
    self.needsUpdateFrameSetter = YES;
    
    //    [self setNeedsDisplay];
}


-(void)setFont:(UIFont *)font{
    _font = font;
    self.needsUpdateAttributeString = YES;
}

//-(NSAttributedString *)attributedText{
//    return _attributedText;
//}

-(UIFont *)font{
    
    if (!_font) {
        return [UIFont fontWithName:@"HiraMinProN-W3" size:14];
    }
    return _font;
}

-(void)setText:(NSString *)text{
    _text = text;
    //    [self updateAttributedString];
    self.needsUpdateAttributeString = YES;
}

-(void)setLinks:(NSArray *)links{
    _links = links;
    self.needsUpdateAttributeString = YES;
}
-(NSAttributedString *)attributedText{
    
    if (self.needsUpdateAttributeString) {
        [self updateAttributedString];
    }
    
    self.needsUpdateAttributeString = NO;
    
    return _attributedText;
}

-(NSObject *)drawParametersForAsyncLayer:(_ASDisplayLayer *)layer{

    AKVerticalTextDrawingParameter * parameters = [[AKVerticalTextDrawingParameter alloc] init];
    parameters.renderer = self.render;
    parameters.backgroundColor = self.backgroundColor.CGColor;
    return parameters;
}

+(void)drawRect:(CGRect)bounds withParameters:(AKVerticalTextDrawingParameter *)parameters isCancelled:(asdisplaynode_iscancelled_block_t)isCancelledBlock isRasterizing:(BOOL)isRasterizing{

    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    // Fill background
    if (!isRasterizing) {
        CGColorRef backgroundColor = parameters.backgroundColor;
        if (backgroundColor) {
            CGContextSetFillColorWithColor(context, backgroundColor);
            CGContextSetBlendMode(context, kCGBlendModeCopy);
            // outset the background fill to cover fractional errors when drawing at a
            // small contentsScale.
            CGContextFillRect(context, CGRectInset(bounds, -2, -2));
            CGContextSetBlendMode(context, kCGBlendModeNormal);
        }
    }
    
/*
    // Draw shadow
    [parameters.shadower setShadowInContext:context];
    
    // Draw text
    bounds.origin = parameters.textOrigin;
    [parameters.renderer drawInRect:bounds inContext:context];
*/
    [parameters.renderer drawAtContext:context];
    CGContextRestoreGState(context);
    

//    if (_framesetter)
//    {
//        CFRelease(_framesetter);
//        _framesetter = NULL;
//    }
    
//    NSAttributedString * attributedString = [(NSDictionary *)parameters objectForKey:@"attributedString"];
    
//    UIGraphicsEndImageContext();
}


@end
