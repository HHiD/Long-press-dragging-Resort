//
//  OrderView.m
//  DragAndMoveAnimataTest
//
//  Created by HongDi Huang on 07/11/2016.
//  Copyright © 2016 HongDi Huang. All rights reserved.
//

#import "OrderView.h"
#import "OrderDetailView.h"


@interface OrderView(){
    UIImageView *_currentShadowView;
    OrderDetailView *_veryFristView;
}
@property (nonatomic, assign)NSInteger cellNum;

@end

@implementation OrderView

- (instancetype)initWithCellNumber:(NSInteger)cellNumber
{
    self = [super init];
    if (self) {
        _cellNum = cellNumber;
        [self setupViews];
        [self gestureConfiguration];
    }
    return self;
}

+ (instancetype)setupWithCellNumber:(NSInteger)cellNum{
    return [[self alloc] initWithCellNumber:cellNum];
}

- (void)setupViews{
    for (NSInteger i = 0; i < _cellNum; i ++) {
        NSInteger originY = i * UNIT_HEIGHT + i * UNIT_GAP;
        OrderDetailView *view = [OrderDetailView new];
        view.backgroundColor = [UIColor redColor];
        if (i == _cellNum - 1) {
            view.backgroundColor = [UIColor blueColor];
        }

        view.frame = CGRectMake(0, originY,
                                ORDERVIEW_WIDTH, UNIT_HEIGHT);
        [self addSubview:view];
    }
}

- (void)gestureConfiguration{
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressGestureHandle:)];
    [self addGestureRecognizer:longPressGesture];
}

- (void)longpressGestureHandle:(UILongPressGestureRecognizer *)longpressGesture{
    switch (longpressGesture.state) {
        case UIGestureRecognizerStateBegan:{
            
            _veryFristView = (OrderDetailView *)[self getDetailView:longpressGesture];
            _veryFristView.alpha = 0;
            if(_veryFristView){
                _currentShadowView = [self createShadowView:_veryFristView];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:{
            
            if (_currentShadowView) {
                _currentShadowView.center = CGPointMake(_currentShadowView.center.x, [longpressGesture locationInView:self].y);
            }
            OrderDetailView *nextView = (OrderDetailView *)[self getDetailView:longpressGesture];
            if (nextView != _veryFristView && nextView) {
                CGFloat nextY = nextView.center.y;
                CGFloat fristY = _veryFristView.center.y;
                CGFloat movePointY = [longpressGesture locationInView:self].y;
                
                if (fristY < nextY) {
                    //Up side
                    if (movePointY > nextY) {
                        [self animateView:nextView];
                    }
                }
                else{
                    //Down side
                    if (movePointY < nextY) {
                        [self animateView:nextView];
                    }
                }
                
            }
        }
            break;
        case UIGestureRecognizerStateRecognized:{
            [self cleanSlate];
        }
            break;
        default:
            break;
    }
}

- (UIView *)getDetailView:(UIGestureRecognizer *)gesture{
    UIView *detailView = [self hitTest:[gesture locationInView:self] withEvent:nil];
    return ([detailView isKindOfClass:[OrderDetailView class]]) ? detailView : nil;
}

- (UIImage *) imageFromView:(UIView *)view {
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0f);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    UIImage *snapshotImageFromMyView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImageFromMyView;
}


- (UIImageView *)createShadowView:(OrderDetailView *)detailView{
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self imageFromView:detailView]];
    imageView.frame = detailView.frame;
    [self addSubview:imageView];

    [UIView animateWithDuration:.3 animations:^{
        imageView.bounds = CGRectInset(detailView.frame, -5, -5);
    }];
    
    return imageView;
}

- (void)cleanSlate{
    [UIView animateWithDuration:.3 animations:^{
        _currentShadowView.frame = _veryFristView.frame;
    } completion:^(BOOL finished) {
        [_currentShadowView removeFromSuperview];
        _currentShadowView = nil;
        _veryFristView.alpha = 1;
        _veryFristView = nil;
    }];
}

- (void)animateView:(UIView *)nextView{
    
    [UIView animateWithDuration:.3 animations:^{
        CGRect beginningFrame = _veryFristView.frame;
        _veryFristView.frame = nextView.frame;
        nextView.frame = beginningFrame;
    }];
    
}

@end
