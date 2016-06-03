//
//  ProvinceController.m
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "ProvinceController.h"
#import "Province.h"

@implementation ProvinceController

//--------------------------------------------------------------------------------------------------------------------------------
+ (instancetype)sharedInstance {
    static ProvinceController *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        // Initialize the session
        _sharedInstance = [[ProvinceController alloc] init];
    });
    return _sharedInstance;
}
//--------------------------------------------------------------------------------------------------------------------------------
-(NSArray*)provinces
{
    NSMutableArray *provinces = [[NSMutableArray alloc] initWithCapacity:24];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"provincias" ofType:@"json"];
    NSString *json = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
    NSError *error =  nil;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error];
    
    if(!error && array){
        for(NSDictionary *dic in array){
            Province *prov = [[Province alloc] initWithDictionary:dic];
            [provinces addObject:prov];
        }
    }
    return provinces;
}
//--------------------------------------------------------------------------------------------------------------------------------

@end
