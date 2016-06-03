//
//  DetailViewController.h
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Province.h"
#import "BaseViewController.h"

@interface DetailViewController : BaseViewController
@property(nonatomic,strong) Province *province;
@end
