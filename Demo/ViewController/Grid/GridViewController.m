//
//  GridViewController.m
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "GridViewController.h"
#import "Procedure.h"
#import "ProceduresController.h"
#import "ProcedureCollectionViewCell.h"

@interface GridViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong) NSArray *items;
@end

@implementation GridViewController
//--------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Grilla";
    self.items = [[ProceduresController sharedInstance] procedures];
}
//--------------------------------------------------------------------------------------------------
#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ProcedureCollectionViewCell* cell = (ProcedureCollectionViewCell*) [self.collectionView dequeueReusableCellWithReuseIdentifier:@"ProcedureCollectionViewCell" forIndexPath:indexPath];
    Procedure *procedure = [self.items objectAtIndex:indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:procedure.iconName];
    cell.titleLabel.text = procedure.title;
    cell.descriptionLabel.text = procedure.procedureDescription;
    return cell;
}
//--------------------------------------------------------------------------------------------------
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.items.count;
}
//--------------------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//--------------------------------------------------------------------------------------------------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        reusableview = footerview;
    }
    
    return reusableview;
}
//--------------------------------------------------------------------------------------------------
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    Procedure *procedure = [self.items objectAtIndex:indexPath.row];
    [[[UIApplication sharedApplication] keyWindow] makeToast:procedure.title image:[UIImage imageNamed:@"toast_info_icon.png"] duration:kToastDuration];
}
//--------------------------------------------------------------------------------------------------
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}
//--------------------------------------------------------------------------------------------------
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frameWidth - 8*3)/ 2.0, 280);
}


@end
