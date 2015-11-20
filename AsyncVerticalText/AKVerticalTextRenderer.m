//
//  AKVerticalTextRenderer.m
//  AsyncVerticalText
//
//  Created by Kent on 11/20/15.
//  Copyright © 2015 Kent. All rights reserved.
//

#import "AKVerticalTextRenderer.h"
#import <CoreText/CoreText.h>

@implementation AKVerticalTextRenderer{
    NSMutableArray * lineInfoForTap;
    CTFramesetterRef _framesetter;
    CTFrameRef _frame;
    NSAttributedString * _attributedText;
    CGSize _containerSize;
}

-(instancetype)initWithAttributedText:(NSAttributedString *)attributedText size:(CGSize)size{
    self = [super init];
    if (self) {
        _attributedText = attributedText;
        _containerSize = size;
    }
    return self;
}

-(void)drawAtContext:(CGContextRef)context{

    [self updateFramesetter];
    
    CGContextRotateCTM(context, M_PI_2);
    //    CGContextTranslateCTM(context, 30.0, 35.0);//偏移
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFrameDraw(_frame, context);
    
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    
    CGRect rect = CGRectMake(0.0, 0.0, _containerSize.height, _containerSize.width);
    CGRect frameBoundingBox = rect;
    CFArrayRef lines = CTFrameGetLines(_frame);
    CGPoint origins[CFArrayGetCount(lines)];                              // the origins of each line at the baseline
    CTFrameGetLineOrigins(_frame, CFRangeMake(0, 0), origins);
    CFIndex linesCount = CFArrayGetCount(lines);
    lineInfoForTap = [[NSMutableArray alloc] initWithCapacity:10];
    for (int lineIdx = 0; lineIdx < linesCount; lineIdx++)
    {
        CGContextSetTextPosition(context, origins[lineIdx].x + frameBoundingBox.origin.x, frameBoundingBox.origin.y + origins[lineIdx].y);
        CTLineRef line = (CTLineRef)CFArrayGetValueAtIndex(lines, lineIdx);
        CGRect lineBounds = CTLineGetImageBounds(line, context);
        lineBounds = CGRectMake(lineBounds.origin.y, lineBounds.origin.x, lineBounds.size.height, lineBounds.size.width);
        //        lineBounds.origin.y = self.frame.size.height - origins[lineIdx].y - lineBounds.size.height;
        CFRange lineRange = CTLineGetStringRange(line);
        
        [lineInfoForTap addObject:[NSDictionary dictionaryWithObjectsAndKeys:NSStringFromRange(NSMakeRange(lineRange.location, lineRange.length)), @"Range", NSStringFromCGRect(lineBounds), @"Bounds", nil]];
        
        
        /*
         UIBezierPath * path = [UIBezierPath bezierPathWithRect:lineBounds];
         [[[UIColor redColor] colorWithAlphaComponent:0.5] setFill];
         [path fill];
         */
        
    }
    
}

-(void)updateFramesetter{

    
    _framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)_attributedText);
    
    
    CGRect rect = CGRectMake(0.0, 0.0, _containerSize.height, _containerSize.width);
    CGPathRef path = CGPathCreateWithRect(rect, nil);
    
    _frame = CTFramesetterCreateFrame(_framesetter, CFRangeMake(0, 0), path, nil);
    
    CGPathRelease(path);

    //    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [[UIScreen mainScreen] scale]);

    
    //    _renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    //    CGPathRef path = CGPathCreateWithRect(CGRectMake(0.0, 0.0, rect.size.height, rect.size.width), nil);
    
    //    CGRect frameBoundingBox = CGPathGetBoundingBox(path);


}
@end
