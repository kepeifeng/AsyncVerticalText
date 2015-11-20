//
//  AKVerticalTextNode.h
//  AsyncVerticalText
//
//  Created by Kent on 11/20/15.
//  Copyright © 2015 Kent. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>
#import "WTLink.h"

@protocol WTVerticalTextViewDelegate;
@interface AKVerticalTextNode : ASControlNode

@property (nonatomic, weak) id<WTVerticalTextViewDelegate> delegate;
@property (nonatomic, strong) NSString * text;
@property (nonatomic, strong) NSAttributedString * attributedText;
@property (nonatomic, copy) UIFont * font;
@property (nonatomic, assign) CGFloat minimumLineHeight;
@property (nonatomic, strong) NSArray * links;

@end

@protocol WTVerticalTextViewDelegate <NSObject>
@optional
-(void)textView:(AKVerticalTextNode *)textView linkTapped:(id<WTAttributedStringLink>)link;

@end