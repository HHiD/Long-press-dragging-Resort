//
//  OrderView.h
//  DragAndMoveAnimataTest
//
//  Created by HongDi Huang on 07/11/2016.
//  Copyright © 2016 HongDi Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ORDERVIEW_WIDTH 300
#define UNIT_HEIGHT 30
#define UNIT_GAP 30
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height
@interface OrderView : UIView
+ (instancetype)setupWithCellNumber:(NSInteger)cellNum;
@end
