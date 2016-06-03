//
//  Province.h
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province :  NSObject <NSObject, NSCoding>

@property(nonatomic,strong) NSString *provinceId;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *iconUrl;
@property(nonatomic,strong) NSString *bannerUrl;
@property(nonatomic,strong) NSString *provinceDescription;

-(id)initWithDictionary:(NSDictionary*)dic;

@end
