//
//  Report.m
//  TresFebrero
//
//  Created by Sergio Cirasa on 2/10/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

#import "Report.h"

#define kReportIdKey @"id"
#define kReportNameKey @"titulo"
#define kReportTextKey @"texto"
#define kReportImageKey @"imagen"
#define kReportStatusKey @"estado"
#define kReportTypeKey @"categoria"
#define kReportAddressKey @"direccion"
#define kReportLatitudeKey @"lat"
#define kReportLongitudeKey @"lng"

@implementation Report

//--------------------------------------------------------------------------------------------------------------------
-(id)initWithDictionary:(NSDictionary*)obj
{
    self = [super init];
    if(self){
        self.reportId = getValue(obj, kReportIdKey);;
        self.title = getValue(obj, kReportNameKey);;
        self.text = getValue(obj, kReportTextKey);
        self.image = getValue(obj, kReportImageKey);
        self.type = [getValue(obj, kReportTypeKey) integerValue];
        self.status = [getValue(obj,kReportStatusKey) integerValue];
        self.address = getValue(obj, kReportAddressKey);
        self.latitude = getValue(obj, kReportLatitudeKey);
        self.longitude = getValue(obj, kReportLongitudeKey);
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------
-(UIColor*)reportColor
{
    return [Report reportTypeColor:self.type];
}
//--------------------------------------------------------------------------------------------------------------------
#pragma mark - NSCoding Methods
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.reportId forKey:kReportIdKey];
    [aCoder encodeObject:self.title forKey:kReportNameKey];
    [aCoder encodeObject:self.text forKey:kReportTextKey];
    [aCoder encodeObject:self.image forKey:kReportImageKey];
    [aCoder encodeInteger:self.type forKey:kReportTypeKey];
    [aCoder encodeInteger:self.status forKey:kReportStatusKey];
    [aCoder encodeObject:self.address forKey:kReportAddressKey];
    [aCoder encodeObject:self.latitude forKey:kReportLatitudeKey];
    [aCoder encodeObject:self.longitude forKey:kReportLongitudeKey];
}
//--------------------------------------------------------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.reportId = [aDecoder decodeObjectForKey:kReportIdKey];
        self.title = [aDecoder decodeObjectForKey:kReportNameKey];
        self.text = [aDecoder decodeObjectForKey:kReportTextKey];
        self.image = [aDecoder decodeObjectForKey:kReportImageKey];
        self.type = [aDecoder decodeIntegerForKey:kReportTypeKey];
        self.status = [aDecoder decodeIntegerForKey:kReportStatusKey];
        self.address = [aDecoder decodeObjectForKey:kReportAddressKey];
        self.latitude = [aDecoder decodeObjectForKey:kReportLatitudeKey];
        self.longitude = [aDecoder decodeObjectForKey:kReportLongitudeKey];
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------
-(BOOL)isEqual:(id)object
{
    if([object isKindOfClass:Report.class]){
        return [self.reportId isEqualToString:((Report*)object).reportId];
    }
    return NO;
}
//------------------------------------------------------------------------------------------------------------
#pragma mark Class Methods
+(NSString*)genderText:(Gender)gender
{
    switch (gender) {
        case MALE:
            return @"Masculino";
        case FEMALE:
            return @"Femenino";
    }
}
//------------------------------------------------------------------------------------------------------------
+(NSString*)reportTypeText:(ReportType)type
{
    switch (type) {
        case SIDEWALKS_AND_STREETS:
            return @"VEREDAS Y CALLES";
        case CLEANING:
            return @"LIMPIEZA";
        case GREEN_AREAS:
            return @"ESPACIOS VERDES Y ARBOLEDAS";
        case PUBLIC_ROAD:
            return @"MOBILIARIO VIA PUBLICA";
        case LUMINARY:
            return @"LUMINARIA";
    }
}
//------------------------------------------------------------------------------------------------------------
-(NSString*)reportTypeText
{
    return [Report reportTypeText:self.type];
}
//------------------------------------------------------------------------------------------------------------
+(UIColor*)reportTypeColor:(ReportType)type
{
    switch (type) {
        case SIDEWALKS_AND_STREETS:
            return [UIColor colorWithRed:213.0/255.0 green:56.0/255.0 blue:58.0/255.0 alpha:1.0];
        case CLEANING:
            return [UIColor colorWithRed:151.0/255.0 green:62.0/255.0 blue:184.0/255.0 alpha:1.0];
        case GREEN_AREAS:
            return [UIColor colorWithRed:41.0/255.0 green:170.0/255.0 blue:80.0/255.0 alpha:1.0];
        case PUBLIC_ROAD:
            return [UIColor colorWithRed:56.0/255.0 green:117.0/255.0 blue:200.0/255.0 alpha:1.0];
        case LUMINARY:
            return [UIColor colorWithRed:222.0/255.0 green:120.0/255.0 blue:45.0/255.0 alpha:1.0];
    }
}
//------------------------------------------------------------------------------------------------------------
-(UIColor*)reportTypeColor
{
    return [Report reportTypeColor:self.type];
}
//------------------------------------------------------------------------------------------------------------
+(NSString*)reportStatusText:(ReportStatus)status
{
    switch (status) {
        case REPORTED:
            return @"Reportado";
        case IN_PROGRESS:
            return @"En Proceso";
        case RESOLVED:
            return @"Resuelto";
    }
}
//------------------------------------------------------------------------------------------------------------
-(NSString*)reportStatusText
{
    return [Report reportStatusText:self.status];
}
//------------------------------------------------------------------------------------------------------------
+(UIImage*)reportIconForType:(ReportType)type status:(ReportStatus) status
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"pin-%d-%d.png",type,status]];
}
//------------------------------------------------------------------------------------------------------------
-(UIImage*)reportAnnotationIcon
{
    return [Report reportIconForType:self.type status:self.status];
}

@end
