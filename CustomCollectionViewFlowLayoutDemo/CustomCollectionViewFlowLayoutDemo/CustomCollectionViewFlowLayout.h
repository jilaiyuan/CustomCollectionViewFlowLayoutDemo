//
//  CustomCollectionViewFlowLayout.h
//  CustomCollectionViewFlowLayoutDemo
//
//  Created by Admin on 2019/12/27.
//  Copyright © 2019 com.personal.project. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomCollectionViewFlowLayout : UICollectionViewFlowLayout

/** item count in one row */
@property (nonatomic, assign) NSInteger columnCount;

/** item count in one column */
@property (nonatomic, assign) NSInteger rowCount;

@end

NS_ASSUME_NONNULL_END
