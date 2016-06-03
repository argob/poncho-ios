//
//  FileManager.h
//  Demo
//
//  Created by Sergio Cirasa on 1/29/16.
//  Copyright © 2016 Bytelion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileManager : NSObject

+(void)setRootFolderName:(NSString*)folderName;

+(BOOL)saveString:(NSString*)string key:(NSString*)key;
+(BOOL)saveData:(NSData*)data key:(NSString*)key;
+(BOOL)saveObject:(id)object key:(NSString*)key;

+(NSString*)loadStringWithKey:(NSString*)key;
+(NSData*)loadDataWithKey:(NSString*)key;
+(id)loadObjectWithKey:(NSString*)key;

+(void)removeFileWithKey:(NSString*)key;
+(NSTimeInterval)timeIntervalSinceTheLastUpdate:(NSString*)key;

@end
