//
//  ViewController.m
//  SlideMenuDemo
//
//  Created by Sergio Cirasa on 5/17/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "ListViewController.h"
#import "ProvinceController.h"
#import "Province.h"
#import "ProvinceTableViewCell.h"
#import "DetailViewController.h"

@interface ListViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSArray *list;
@end

@implementation ListViewController

//-----------------------------------------------------------------------------------------------------------------------------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Lista";
    self.list = [[ProvinceController sharedInstance] provinces];
}
//-----------------------------------------------------------------------------------------------------------------------------
#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *vc = [UIStoryboard instantiateDetailViewController];
    vc.province = [self.list objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
//-----------------------------------------------------------------------------------------------------------------------------
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    return self.list.count;
}
//-----------------------------------------------------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProvinceTableViewCell";
    ProvinceTableViewCell *cell = (ProvinceTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    Province *prov = [self.list objectAtIndex:indexPath.row];
    cell.titleLabel.text = prov.title;
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:prov.iconUrl] placeholderImage:[UIImage imageNamed:@"provincePlaceholder.png"]];

    return cell;
}
//-----------------------------------------------------------------------------------------------------------------------------
@end
