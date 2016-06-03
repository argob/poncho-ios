//
//  ProceduresController.m
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "ProceduresController.h"
#import "Procedure.h"

@implementation ProceduresController

//--------------------------------------------------------------------------------------------------------------------------------
+ (instancetype)sharedInstance {
    static ProceduresController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        // Initialize the session
        _sharedInstance = [[ProceduresController alloc] init];
    });
    return _sharedInstance;
}
//--------------------------------------------------------------------------------------------------------------------------------
-(NSArray*)procedures
{
    NSMutableArray *procedures = [[NSMutableArray alloc] initWithCapacity:24];
    NSArray* array = [NSArray arrayWithContentsOfFile:[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Procedures.plist"]];
    if(array){
        for(NSDictionary *dic in array){
            Procedure *prov = [[Procedure alloc] initWithDictionary:dic];
            [procedures addObject:prov];
        }
    }
    return procedures;
}
//--------------------------------------------------------------------------------------------------------------------------------

@end
