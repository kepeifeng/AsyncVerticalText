//
//  ViewController.m
//  AsyncVerticalText
//
//  Created by Kent on 11/20/15.
//  Copyright © 2015 Kent. All rights reserved.
//

#import "ViewController.h"
#import "AKVerticalTextNode.h"

@interface ViewController ()

@end

@implementation ViewController{
    AKVerticalTextNode * _verticalNode;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _verticalNode = [[AKVerticalTextNode alloc] init];
    _verticalNode.text = @"今天天气不错";
    _verticalNode.frame = self.view.bounds;
    _verticalNode.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_verticalNode.view];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
