//
//  Procedure.m
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "Procedure.h"

#define kProcedureTitleKey @"title"
#define kProcedureIconKey @"icon"
#define kProcedureDescriptionKey @"description"

@implementation Procedure

//--------------------------------------------------------------------------------------------------------------------
-(id)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    if(self){
        self.title = getValue(dic,kProcedureTitleKey);
        self.iconName = getValue(dic,kProcedureIconKey);
        self.procedureDescription = getValue(dic,kProcedureDescriptionKey);
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------
#pragma mark - NSCoding Methods
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:kProcedureTitleKey];
    [aCoder encodeObject:self.iconName forKey:kProcedureIconKey];
    [aCoder encodeObject:self.procedureDescription forKey:kProcedureDescriptionKey];
}
//--------------------------------------------------------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:kProcedureTitleKey];
        self.iconName = [aDecoder decodeObjectForKey:kProcedureIconKey];
        self.procedureDescription = [aDecoder decodeObjectForKey:kProcedureDescriptionKey];
    }
    return self;
}

@end
