//
//  AKVerticalTextDrawingParameter.h
//  AsyncVerticalText
//
//  Created by Kent on 11/20/15.
//  Copyright © 2015 Kent. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKVerticalTextRenderer.h"

@interface AKVerticalTextDrawingParameter : NSObject
@property (nonatomic) AKVerticalTextRenderer * renderer;
@property (nonatomic) CGColorRef backgroundColor;
@end
