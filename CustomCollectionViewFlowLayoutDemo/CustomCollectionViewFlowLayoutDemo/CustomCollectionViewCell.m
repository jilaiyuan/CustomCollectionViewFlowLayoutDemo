//
//  CustomCollectionViewCell.m
//  CustomCollectionViewFlowLayoutDemo
//
//  Created by Admin on 2019/12/27.
//  Copyright © 2019 com.personal.project. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *countLabel;

@end

@implementation CustomCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews
{
    UIImageView *imgV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lennart_heim.jpg"]];
    imgV.frame = self.contentView.bounds;
    imgV.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.contentView addSubview:imgV];
    self.imageView = imgV;
    [imgV release];
    
    UILabel *countLabel = [[UILabel alloc] init];
    countLabel.font = [UIFont boldSystemFontOfSize:14];
    countLabel.textColor = UIColor.redColor;
    countLabel.textAlignment = NSTextAlignmentLeft;
    countLabel.frame = CGRectMake(0, 0, 100, 20);
    countLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self.contentView addSubview:countLabel];
    self.countLabel = countLabel;
    [countLabel release];
}

- (void)setCount:(NSUInteger)count
{
    self.countLabel.text = [NSString stringWithFormat:@"%lu",count];
}

- (void)setImage
{
    self.imageView.image = [UIImage imageNamed:@"lennart_heim.jpg"];
}

- (void)dealloc
{
    self.imageView = nil;
    self.countLabel = nil;
    
    [super dealloc];
}

@end
