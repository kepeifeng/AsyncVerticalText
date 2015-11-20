//
//  AKVerticalTextDrawingParameter.m
//  AsyncVerticalText
//
//  Created by Kent on 11/20/15.
//  Copyright © 2015 Kent. All rights reserved.
//

#import "AKVerticalTextDrawingParameter.h"

@implementation AKVerticalTextDrawingParameter

-(void)setBackgroundColor:(CGColorRef)backgroundColor{
    if (_backgroundColor) {
        CGColorRelease(_backgroundColor);
    }
    _backgroundColor = CGColorRetain(backgroundColor);
    
}

-(void)dealloc{

    if (_backgroundColor) {
        CGColorRelease(_backgroundColor);
    }
}
@end
