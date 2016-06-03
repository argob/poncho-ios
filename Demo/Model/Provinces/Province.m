//
//  Province.m
//  Demo
//
//  Created by Sergio Cirasa on 6/2/16.
//  Copyright © 2016 Ministerio de Modernizacion. All rights reserved.
//

#import "Province.h"

#define kProvinceIdKey @"id"
#define kProvinceTitleKey @"title"
#define kProvinceIconKey @"icon"
#define kProvinceBannerKey @"banner"
#define kProvinceDescriptionKey @"description"

@implementation Province

//--------------------------------------------------------------------------------------------------------------------
-(id)initWithDictionary:(NSDictionary*)dic
{
    self = [super init];
    if(self){
        self.provinceId = getValue(dic,kProvinceIdKey);
        self.title = getValue(dic,kProvinceTitleKey);
        self.iconUrl = getValue(dic,kProvinceIconKey);
        self.bannerUrl = getValue(dic,kProvinceBannerKey);
        self.provinceDescription = getValue(dic,kProvinceDescriptionKey);
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------
#pragma mark - NSCoding Methods
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.provinceId forKey:kProvinceIdKey];
    [aCoder encodeObject:self.title forKey:kProvinceTitleKey];
    [aCoder encodeObject:self.iconUrl forKey:kProvinceIconKey];
    [aCoder encodeObject:self.bannerUrl forKey:kProvinceBannerKey];
    [aCoder encodeObject:self.provinceDescription forKey:kProvinceDescriptionKey];
}
//--------------------------------------------------------------------------------------------------------------------
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    if (self) {
        self.provinceId = [aDecoder decodeObjectForKey:kProvinceIdKey];
        self.title = [aDecoder decodeObjectForKey:kProvinceTitleKey];
        self.iconUrl = [aDecoder decodeObjectForKey:kProvinceIconKey];
        self.bannerUrl = [aDecoder decodeObjectForKey:kProvinceBannerKey];
        self.provinceDescription = [aDecoder decodeObjectForKey:kProvinceDescriptionKey];
    }
    return self;
}
//--------------------------------------------------------------------------------------------------------------------
-(NSString*)objectId
{
    return self.provinceId;
}
//--------------------------------------------------------------------------------------------------------------------
-(BOOL)isEqual:(id)object
{
    if(![object isKindOfClass:Province.class])
        return NO;
    
    Province *prov = object;
    if([self.provinceId isEqualToString:prov.provinceId]){
        return YES;
    }
    return NO;
}
//--------------------------------------------------------------------------------------------------------------------

@end
