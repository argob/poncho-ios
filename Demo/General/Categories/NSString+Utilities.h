//
//  NSString+Utilities.h
//
//  Created by Sergio Cirasa on 01/12/13.
//  Copyright (c) 2013 Creative Coefficient. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Utilities)

+(BOOL) isValidEmailAddress: (NSString *) candidate;
-(BOOL) isValidEmailAddress;

+(BOOL) isTheUrlOfAnImage:(NSString*) url;
-(BOOL) isTheUrlOfAnImage;

+(BOOL) validateUrl: (NSString *) candidate;
-(BOOL) validateUrl;

+(NSString*)removeExtraCarriageReturnChars:(NSString*)text;
+(NSAttributedString*)createAttributedString:(NSString*)text font:(UIFont*)font;

-(NSString*)stylizeString;
@end
