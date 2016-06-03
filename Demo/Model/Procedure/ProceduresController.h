//
//  ProceduresController.h
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProceduresController : NSObject

+ (instancetype)sharedInstance;

-(NSArray*)procedures;

@end
