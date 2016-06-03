//
//  Procedure.h
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Procedure : NSObject <NSObject, NSCoding>

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *iconName;
@property(nonatomic,strong) NSString *procedureDescription;

-(id)initWithDictionary:(NSDictionary*)dic;

@end
