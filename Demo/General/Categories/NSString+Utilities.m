//
//  NSString+Utilities.m
//
//  Created by Sergio Cirasa on 01/12/13.
//  Copyright (c) 2013 Creative Coefficient. All rights reserved.
//

#import "NSString+Utilities.h"

#define kDefaultDateFormat (@"yyyy-MM-dd'T'HH:mm:ssZ")

@implementation NSString (Utilities)

#pragma mark - Validations methods
//--------------------------------------------------------------------------------------------------------
+(BOOL) isValidEmailAddress: (NSString *) candidate
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 	
    return [emailTest evaluateWithObject:candidate];
}
//--------------------------------------------------------------------------------------------------------
-(BOOL) isValidEmailAddress
{
    return [NSString isValidEmailAddress:self];
}
//------------------------------------------------------------------------------------------------------------------------------
+(BOOL) isTheUrlOfAnImage:(NSString*) url
{
	
	NSArray *listItems = [url componentsSeparatedByString:@"."];
	
	if([listItems count]>0){
		NSString *format = [[listItems objectAtIndex:[listItems count]-1] lowercaseString];
		
		if([format compare:@"jpg"]==NSOrderedSame)
			return TRUE;
		
		if([format compare:@"jpeg"]==NSOrderedSame)
			return TRUE;
		
		if([format compare:@"png"]==NSOrderedSame)
			return TRUE;		
	}	
	
	return FALSE;	
}
//--------------------------------------------------------------------------------------------------------
-(BOOL) isTheUrlOfAnImage
{
    return [NSString isTheUrlOfAnImage:self];
}
//--------------------------------------------------------------------------------------------------------
+ (BOOL) validateUrl: (NSString *) candidate
{
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx]; 
    return [urlTest evaluateWithObject:candidate];
}
//--------------------------------------------------------------------------------------------------------
-(BOOL) validateUrl
{
    return [NSString validateUrl:self];
}
//--------------------------------------------------------------------------------------------------------
+(NSString*)removeExtraCarriageReturnChars:(NSString*)text
{
    if(text==nil || [text length]==0)
        return text;
    
    BOOL exit = NO;
    
    while(!exit && text.length>0){
        NSString *lastCharacter = [text substringWithRange:NSMakeRange(text.length-1, 1)];
        if([lastCharacter isEqualToString:@"\n"])
            text = [text substringWithRange:NSMakeRange(0, text.length-1)];
        else exit=YES;
    }
    
    exit=NO;
    while(!exit && text.length>0){
        NSString *firstCharacter = [text substringWithRange:NSMakeRange(0, 1)];
        if([firstCharacter isEqualToString:@"\n"])
            text = [text substringWithRange:NSMakeRange(1, text.length-1)];
        else exit=YES;
    }
    
        exit=NO;
    while(!exit){
        NSUInteger lenth = text.length;
        text = [text stringByReplacingOccurrencesOfString:@"\n\n\n" withString:@"\n\n"];
        if(lenth==text.length)
            exit=YES;
    }
    
    return text;
}
//--------------------------------------------------------------------------------------------------------
+(NSAttributedString*)createAttributedString:(NSString*)text font:(UIFont*)font
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{ NSFontAttributeName: font}];
    NSUInteger startPosition = 0;
    
    while(startPosition<text.length){
        NSRange numberRange = [text rangeOfString:@"#" options:NSCaseInsensitiveSearch range:NSMakeRange(startPosition, text.length-startPosition)];
        if(numberRange.location !=NSNotFound){
            NSRange spaceRange = [text rangeOfString:@" " options:NSCaseInsensitiveSearch range:NSMakeRange(numberRange.location+1, text.length-(numberRange.location+1))];
            
            NSRange enterRange = [text rangeOfString:@"\n" options:NSCaseInsensitiveSearch range:NSMakeRange(numberRange.location+1, text.length-(numberRange.location+1))];
            
            NSUInteger toLocation = [text length];
            if(spaceRange.location!=NSNotFound && enterRange.location!=NSNotFound){
                if(spaceRange.location < enterRange.location)
                    toLocation = spaceRange.location;
                else toLocation = enterRange.location;
            }else if(spaceRange.location!=NSNotFound){
                toLocation = spaceRange.location;
            }else if(enterRange.location!=NSNotFound){
                toLocation = enterRange.location;
            }
            
            NSRange hashtagRange = NSMakeRange(numberRange.location, toLocation-numberRange.location);
            NSString *hashtag = [text substringWithRange:hashtagRange];
            
            [attributedString addAttribute:NSLinkAttributeName
                                     value:[NSString stringWithFormat:@"samegrain://%@",hashtag]
                                     range:hashtagRange];
            
            startPosition = toLocation;
        }else{
            startPosition = text.length;
        }
    }
    
    return attributedString;
}
//--------------------------------------------------------------------------------------------------------
-(NSString*)stylizeString
{
    if(self.length==0)
        return self;

    NSArray *listItems = [[self lowercaseString] componentsSeparatedByString:@"."];
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:listItems.count];
    for(NSString *str in listItems){
        [array addObject:[str uppercaseFirstCharacter]];
    }
    NSString *text = [array componentsJoinedByString:@"."];
    return text;
}
//--------------------------------------------------------------------------------------------------------
-(NSString*)uppercaseFirstCharacter
{
    for(NSInteger i=0; i<self.length;i++){
        unichar opt = [self characterAtIndex:i];
        NSCharacterSet *letters = [NSCharacterSet letterCharacterSet];
        if ([letters characterIsMember:opt]) {
            NSMutableString *text = [[NSMutableString alloc] initWithString:self];
            NSString *firstChar = [[self substringWithRange:NSMakeRange(i, 1)] uppercaseString];
            [text replaceCharactersInRange:NSMakeRange(i, 1) withString:firstChar];
            return text;
        }
    }
    
    return self;
}
//--------------------------------------------------------------------------------------------------------
@end


