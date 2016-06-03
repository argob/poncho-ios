//
//  SlideMenuViewController.m
//  SlideMenuDemo
//
//  Created by Sergio Cirasa on 5/17/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "SliderMenuViewController.h"
#import "SliderMenuTableViewCell.h"

@interface SliderMenuViewController () <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,weak) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSArray *menuData;
@end

@implementation SliderMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.alwaysBounceVertical=NO; //Deja Scrollear solo si es necesario
    self.menuData = [NSArray arrayWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Menu.plist"]];
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *menuItemData = self.menuData[indexPath.row];
    [self.delegate performSelector:NSSelectorFromString(menuItemData[@"event_name"])];
}
#pragma clang diagnostic pop

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{   
    return self.menuData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SliderMenuTableViewCell";
    SliderMenuTableViewCell *cell = (SliderMenuTableViewCell*) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];    
    cell.titleLabel.text = [[self.menuData objectAtIndex:indexPath.row] objectForKey:@"title"];
    cell.iconImage.image = [UIImage imageNamed:[[self.menuData objectAtIndex:indexPath.row] objectForKey:@"icon"]];
    return cell;
}

@end
