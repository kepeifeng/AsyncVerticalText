//
//  AKVerticalTextRenderer.h
//  AsyncVerticalText
//
//  Created by Kent on 11/20/15.
//  Copyright © 2015 Kent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AKVerticalTextRenderer : NSObject
-(instancetype)initWithAttributedText:(NSAttributedString *)attributedText size:(CGSize)size;
-(void)drawAtContext:(CGContextRef)context;
@end
