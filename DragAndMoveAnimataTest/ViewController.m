//
//  ViewController.m
//  DragAndMoveAnimataTest
//
//  Created by HongDi Huang on 07/11/2016.
//  Copyright © 2016 HongDi Huang. All rights reserved.
//

#import "ViewController.h"
#import "OrderView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    OrderView *unitOrderView = [OrderView setupWithCellNumber:4];
    NSInteger originX = (SCREEN_WIDTH - ORDERVIEW_WIDTH)/2;
    NSInteger originY = 50;
    NSInteger width = ORDERVIEW_WIDTH;
    NSInteger height = UNIT_HEIGHT * 4 + (4 - 1) * UNIT_GAP;
    unitOrderView.frame = CGRectMake(originX, originY, width, height);
    unitOrderView.backgroundColor = [UIColor blackColor]; 
    [self.view addSubview:unitOrderView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
