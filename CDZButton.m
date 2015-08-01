//
//  CDZButton.m
//
//
//  Created by baight on 14-5-15.
//  Copyright (c) 2014年 baight. All rights reserved.
//

#import "CDZButton.h"

@implementation CDZButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _myInit];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self _myInit];
    }
    return self;
}
-(void)_myInit{
    _interval = -1.0;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    switch (_type) {
        case CBTypeDefault:
            break;
        case CBTypeVertical:
        {
            self.titleLabel.textAlignment = NSTextAlignmentCenter;
            
            CGRect rect = self.titleLabel.frame;
            rect.size.width = self.bounds.size.width;
            self.titleLabel.frame = rect;
            
            [self.titleLabel sizeToFit];
            
            CGFloat px;
            if(_interval == -1.0){
                px = self.bounds.size.width /10;
                if(px > 10){
                    px = 10;
                }
            }
            else{
                px = _interval;
            }
            
            CGFloat valiableHeight = self.titleLabel.bounds.size.height + self.imageView.bounds.size.height + px;
            if(valiableHeight > self.bounds.size.height){
                valiableHeight = self.bounds.size.height;
            }
            
            rect = self.titleLabel.frame;
            rect.size.width = self.bounds.size.width;
            rect.origin.y = (self.bounds.size.height+valiableHeight)/2 - self.titleLabel.bounds.size.height;
            rect.origin.x = 0;
            self.titleLabel.frame = rect;
            
            rect = self.imageView.frame;
            rect.origin.x = (self.bounds.size.width - self.imageView.bounds.size.width)/2;
            rect.origin.y = (self.bounds.size.height-valiableHeight)/2;
            self.imageView.frame = rect;
            break;
        }
        case CBTypeHorizontal:
        {
            self.titleLabel.textAlignment = NSTextAlignmentLeft;
            if(self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter){
                [self.titleLabel sizeToFit];
                CGFloat px;
                if(_interval == -1.0){
                    px = self.bounds.size.width /10;
                    if(px > 10){
                        px = 10;
                    }
                }
                else{
                    px = _interval;
                }
                CGFloat valiableWidth = self.titleLabel.bounds.size.width + self.imageView.bounds.size.width+ px;
                if(valiableWidth > self.bounds.size.width){
                    valiableWidth = self.bounds.size.width;
                }
                
                CGRect rect = self.imageView.frame;
                rect.origin.x = (self.bounds.size.width-valiableWidth)/2;
                rect.origin.y = (self.bounds.size.height - self.imageView.bounds.size.height)/2;;
                self.imageView.frame = rect;
                
                rect = self.titleLabel.frame;
                rect.origin.x = self.imageView.frame.origin.x + self.imageView.frame.size.width + px;
                rect.size.width = self.bounds.size.width - self.titleLabel.frame.origin.x;
                self.titleLabel.frame = rect;
            }
            else{
                CGFloat px;
                if(_interval == -1.0){
                    px = self.bounds.size.width /10;
                    if(px > 10){
                        px = 10;
                    }
                }
                else{
                    px = _interval;
                }
                
                if(self.imageView.image == nil || self.imageView.hidden == YES){
                    CGRect rect = self.titleLabel.frame;
                    rect.origin.x = px;
                    rect.size.width = self.bounds.size.width - self.titleLabel.frame.origin.x - px;
                    self.titleLabel.frame = rect;
                }
                else{
                    CGRect rect = self.imageView.frame;
                    rect.origin.x = px;
                    rect.origin.y = (self.bounds.size.height - self.imageView.bounds.size.height)/2;;
                    self.imageView.frame = rect;
                    
                    rect = self.titleLabel.frame;
                    rect.origin.x = self.imageView.frame.origin.x + self.imageView.frame.size.width + px;
                    rect.size.width = self.bounds.size.width - self.titleLabel.frame.origin.x - px;
                    self.titleLabel.frame = rect;
                }
            }
            break;
        }
        case CBTypeImageOnly:{
            self.imageView.contentMode = self.contentMode;
            self.imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
            break;
        }
        case CBTypeVersaHorizontal:{
            [self.titleLabel sizeToFit];
            
            if(self.imageView.hidden || self.imageView.image == nil){
                CGRect rect = self.titleLabel.frame;
                if(rect.size.width > self.bounds.size.width){
                    rect.size.width = self.bounds.size.width;
                }
                rect.origin.x = (self.bounds.size.width - rect.size.width)/2;
                self.titleLabel.frame = rect;
            }
            else{
                CGFloat px;
                if(_interval == -1.0){
                    px = self.bounds.size.width /10;
                    if(px > 10){
                        px = 10;
                    }
                }
                else{
                    px = _interval;
                }
                
                CGFloat valiableWidth = self.titleLabel.bounds.size.width + self.imageView.bounds.size.width+ px;
                if(valiableWidth > self.bounds.size.width){
                    valiableWidth = self.bounds.size.width;
                }
                
                CGRect rect = self.imageView.frame;
                rect.origin.x = (self.bounds.size.width+valiableWidth)/2 - self.imageView.bounds.size.width;
                rect.origin.y = (self.bounds.size.height - self.imageView.bounds.size.height)/2;;
                self.imageView.frame = rect;
                
                rect = self.titleLabel.frame;
                rect.origin.x = (self.bounds.size.width-valiableWidth)/2;
                rect.size.width = self.imageView.frame.origin.x - rect.origin.x - px;
                self.titleLabel.frame = rect;
            }
        }
            break;
        default:
            break;
    }
}

-(void)setType:(CBType)type{
    _type = type;
    if(type == CBTypeDefault){
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    if(image == nil){
        [self layoutSubviews];
    }
    if(state == UIControlStateNormal){
        _normalImage = image;
    }
}
-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    if(self.type == CBTypeImageOnly){
        [super setImage:image forState:state];
    }
    else{
        [super setBackgroundImage:image forState:state];
    }
    if(state == UIControlStateNormal){
        _normalBackgroundImage = image;
    }
}

-(void)setHighlighted:(BOOL)highlighted{
    [super setHighlighted:highlighted];
    if(_highlightBrotherViews){
        [self setSubViewsOfView:self.superview highlighted:highlighted];
    }
    if(_associatedButton){
        [_associatedButton setHighlighted:highlighted];
    }
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if(_highlightBrotherViews){
        [self setSubViewsOfView:self.superview highlighted:selected];
    }
    if(_associatedButton){
        [_associatedButton setSelected:selected];
    }
    
    UIImage* i = [self imageForState:UIControlStateHighlighted];
    UIImage* n = [self imageForState:UIControlStateNormal];
    if(i== nil || i == n){
        if(selected){
            UIImage* image = [self imageForState:UIControlStateSelected];
            if(image){
                if(_normalImage == nil){
                    _normalImage = [self imageForState:UIControlStateNormal];
                }
                _normalImageChanged = YES;
                [super setImage:image forState:UIControlStateNormal];
            }
        }
        else{
            if(_normalImageChanged){
                _normalImageChanged = NO;
                [self setImage:_normalImage forState:UIControlStateNormal];
                _normalImage = nil;
            }
        }
    }
    i = [self backgroundImageForState:UIControlStateHighlighted];
    n = [self backgroundImageForState:UIControlStateNormal];
    if(i== nil || i == n){
        if(selected){
            UIImage* backgroundImage = [self backgroundImageForState:UIControlStateSelected];
            if(backgroundImage){
                if(_normalBackgroundImage == nil){
                    _normalBackgroundImage = [self backgroundImageForState:UIControlStateNormal];
                }
                _normalBackgroundImageChanged = YES;
                [super setBackgroundImage:backgroundImage forState:UIControlStateNormal];
            }
        }
        else{
            if(_normalBackgroundImageChanged){
                _normalBackgroundImageChanged = NO;
                [self setBackgroundImage:_normalBackgroundImage forState:UIControlStateNormal];
                _normalBackgroundImage = nil;
            }
        }
    }
}
-(void)setEnabled:(BOOL)enabled{
    [super setEnabled:enabled];
    if(_highlightBrotherViews){
        
    }
}
-(void)setSubViewsOfView:(UIView*)view highlighted:(BOOL)highlighted{
    for(UIView* v in view.subviews){
        if([v isKindOfClass:[UILabel class]]){
            [(UILabel*)v setHighlighted:highlighted];
        }
        else if([v isKindOfClass:[UIImageView class]]){
            [(UIImageView*)v setHighlighted:highlighted];
        }
        else if([v isKindOfClass:[UIButton class]]){
            if(v == self){
                continue;
            }
            [(UIButton*)v setHighlighted:highlighted];
        }
        else if([v isKindOfClass:[UIView class]]){
            [self setSubViewsOfView:v highlighted:highlighted];
        }
    }
}

@end


@implementation CDZHorStretchButton
-(void)awakeFromNib{
    UIControlState state = UIControlStateNormal;
    UIImage* image = [self backgroundImageForState:state];
    if(image){
        [self setBackgroundImage:image forState:state];
        image = [self backgroundImageForState:state];
    }
    
    state = UIControlStateHighlighted;
    UIImage* hightImage = [self backgroundImageForState:state];
    if(hightImage != image){
        [self setBackgroundImage:hightImage forState:state];
    }
    
    state = UIControlStateSelected;
    UIImage* selectImage = [self backgroundImageForState:state];
    if(selectImage != image){
        [self setBackgroundImage:selectImage forState:state];
    }
}
-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    if(image.leftCapWidth == 0){
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.topCapHeight];
    }
    [super setBackgroundImage:image forState:state];
}
@end

@implementation CDZVerStretchButton
-(void)awakeFromNib{
    UIControlState state = UIControlStateNormal;
    UIImage* image = [self backgroundImageForState:state];
    if(image){
        [self setBackgroundImage:image forState:state];
        image = [self backgroundImageForState:state];
    }
    
    state = UIControlStateHighlighted;
    UIImage* hightImage = [self backgroundImageForState:state];
    if(hightImage != image){
        [self setBackgroundImage:hightImage forState:state];
    }
    
    state = UIControlStateSelected;
    UIImage* selectImage = [self backgroundImageForState:state];
    if(selectImage != image){
        [self setBackgroundImage:selectImage forState:state];
    }
}
-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    if(image.topCapHeight == 0){
        image = [image stretchableImageWithLeftCapWidth:image.leftCapWidth topCapHeight:image.size.height/2];
    }
    [super setBackgroundImage:image forState:state];
}
@end

@implementation CDZStretchButton
-(void)awakeFromNib{
    UIControlState state = UIControlStateNormal;
    UIImage* image = [self backgroundImageForState:state];
    if(image){
        [self setBackgroundImage:image forState:state];
        image = [self backgroundImageForState:state];
    }
    
    state = UIControlStateHighlighted;
    UIImage* hightImage = [self backgroundImageForState:state];
    if(hightImage != image){
        [self setBackgroundImage:hightImage forState:state];
    }
    
    state = UIControlStateSelected;
    UIImage* selectImage = [self backgroundImageForState:state];
    if(selectImage != image){
        [self setBackgroundImage:selectImage forState:state];
    }
}
-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state{
    if(image.leftCapWidth == 0 || image.topCapHeight == 0){
        image = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    }
    [super setBackgroundImage:image forState:state];
}
@end

