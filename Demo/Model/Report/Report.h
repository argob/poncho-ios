//
//  Report.h
//  TresFebrero
//
//  Created by Sergio Cirasa on 2/10/16.
//  Copyright © 2016 Sergio Cirasa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Gender) {
    MALE = 1,
    FEMALE = 2
};

typedef NS_ENUM(NSUInteger, ReportType) {
    SIDEWALKS_AND_STREETS = 1,
    CLEANING = 2,
    GREEN_AREAS = 3,
    PUBLIC_ROAD = 4,
    LUMINARY = 5
};

typedef NS_ENUM(NSUInteger, ReportStatus) {
    REPORTED = 1,
    IN_PROGRESS = 2,
    RESOLVED = 3
};

@interface Report : NSObject <NSObject, NSCoding>

@property(nonatomic, strong) NSString *reportId;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *text;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, assign) ReportType type;
@property(nonatomic, assign) ReportStatus status;
@property(nonatomic, strong) NSString *address;
@property(nonatomic, strong) NSString *latitude;
@property(nonatomic, strong) NSString *longitude;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *lastname;
@property(nonatomic, strong) NSString *dni;
@property(nonatomic, strong) NSString *phone_area;
@property(nonatomic, strong) NSString *phone_number;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, assign) Gender gender;

-(id)initWithDictionary:(NSDictionary*)dic;

-(UIColor*)reportColor;
+(NSString*)genderText:(Gender)gender;
+(NSString*)reportTypeText:(ReportType)type;
+(UIColor*)reportTypeColor:(ReportType)type;
+(NSString*)reportStatusText:(ReportStatus)status;
+(UIImage*)reportIconForType:(ReportType)type status:(ReportStatus) status;

-(UIImage*)reportAnnotationIcon;
-(NSString*)reportTypeText;
-(NSString*)reportStatusText;
-(UIColor*)reportTypeColor;

@end
