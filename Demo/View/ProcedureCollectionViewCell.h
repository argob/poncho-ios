//
//  ProcedureCollectionViewCell.h
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcedureCollectionViewCell : UICollectionViewCell

@property(nonatomic,weak) IBOutlet UIImageView *imageView;
@property(nonatomic,weak) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet UILabel *descriptionLabel;

@end
