//
//  CDZButton.h
//
//
//  Created by baight on 14-5-15.
//  Copyright (c) 2014年 baight. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    CBTypeDefault = 0,   // 系统按钮
    CBTypeHorizontal = 1,  // image 和 title 水平排列
    CBTypeVertical = 2,    // image 和 title 垂直排列
    CBTypeImageOnly = 3,   // 只显示 image, 其 contentMode 与 button 的一致
    CBTypeVersaHorizontal = 4   // title 和 image 水平排列
}CBType;

@interface CDZButton : UIButton{
    UIImage* _normalImage;
    UIImage* _normalBackgroundImage;
}

@property (nonatomic, assign) CBType type;         // 类型
@property (nonatomic, assign) CGFloat interval;    // image 和 title 之间的间距

// 自己state改变时，是否将父容器的所有子视图 的 state 设置成和自己一样的，默认否
@property (nonatomic, assign) BOOL highlightBrotherViews;

@end

// backgroundImage 从中间水平拉伸
@interface CDZHorStretchButton : CDZButton
@end

// backgroundImage 从中间垂直拉伸
@interface CDZVerStretchButton : CDZButton
@end

// backgroundImage 从中间水平垂直都拉伸
@interface CDZStretchButton : CDZButton
@end