//
//  FileManager.m
//  Demo
//
//  Created by Sergio Cirasa on 1/29/16.
//  Copyright © 2016 Bytelion. All rights reserved.
//

#import "FileManager.h"
#define kLastUpdateFiles @"LastUpdateFiles"

@implementation FileManager

static NSString *rootFolderName = @"";

//------------------------------------------------------------------------------------
+(void)setRootFolderName:(NSString*)folderName
{
    rootFolderName = folderName;
}
//------------------------------------------------------------------------------------
+(NSString*)pathForKey:(NSString*)key
{
    NSError *error;
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
    NSString *path = [url path];
    path = [NSString stringWithFormat:@"%@/%@/",path,rootFolderName];
    
    NSRange range = [key rangeOfString:@"/" options:NSBackwardsSearch];
    
    if(range.location!=NSNotFound){
        NSString *folder = [key substringToIndex:range.location+1];
        path = [NSString stringWithFormat:@"%@%@",path,folder];
        key = [key substringFromIndex:range.location+1];
    }
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return [NSString stringWithFormat:@"%@%@",path,key];
}
//------------------------------------------------------------------------------------
#pragma mark - Save Methods
+(BOOL)saveString:(NSString*)string key:(NSString*)key
{
    NSString *path = [FileManager pathForKey:key];
    NSError *error;
    [string writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    [FileManager saveLastUpdateDateForKey:key];
    return (error==nil);
}
//------------------------------------------------------------------------------------
+(BOOL)saveData:(NSData*)data key:(NSString*)key
{
    NSString *path = [FileManager pathForKey:key];
    [data writeToFile:path atomically:YES];
    [FileManager saveLastUpdateDateForKey:key];
    return YES;
}
//------------------------------------------------------------------------------------
+(BOOL)saveObject:(id)object key:(NSString*)key
{
    NSString *path = [FileManager pathForKey:key];
    [NSKeyedArchiver archiveRootObject:object toFile:path];
    [FileManager saveLastUpdateDateForKey:key];    
    return YES;
}
//------------------------------------------------------------------------------------
#pragma mark - Load Methods
+(NSString*)loadStringWithKey:(NSString*)key
{
    NSError *error;
    NSString *path = [FileManager pathForKey:key];
    NSString *str = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:path] encoding:NSUTF8StringEncoding error:&error];
    return str;
}
//------------------------------------------------------------------------------------
+(NSData*)loadDataWithKey:(NSString*)key
{
    NSString *path = [FileManager pathForKey:key];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return data;
}
//------------------------------------------------------------------------------------
+(id)loadObjectWithKey:(NSString*)key
{
    NSString *path = [FileManager pathForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
//------------------------------------------------------------------------------------
#pragma mark - Remove Methods
+(void)removeFileWithKey:(NSString*)key
{
    NSString *path = [FileManager pathForKey:key];
    NSError *error;
    if(![[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    }
    
    [FileManager removeDateForKey:key];
}
//------------------------------------------------------------------------------------
#pragma mark - Usefull Methods
+(NSTimeInterval)timeIntervalSinceTheLastUpdate:(NSString*)key
{
    NSDate *date = [FileManager lastUpdateDateForKey:key];
    if(date)
        return [date timeIntervalSinceNow]*-1;
    
    return -1;
}
//------------------------------------------------------------------------------------
+(void)saveLastUpdateDateForKey:(NSString*)key
{
    @synchronized(self) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kLastUpdateFiles];
        NSMutableDictionary *allFoldersDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
        if(dic)
            [allFoldersDictionary setDictionary:dic];
        
        NSMutableDictionary *folderDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
        if([allFoldersDictionary objectForKey:rootFolderName]){
            [folderDictionary setDictionary:[allFoldersDictionary objectForKey:rootFolderName]];
        }
        
        [folderDictionary setObject:[NSDate date] forKey:key];
        [allFoldersDictionary setObject:folderDictionary forKey:rootFolderName];
        [[NSUserDefaults standardUserDefaults] setObject:allFoldersDictionary forKey:kLastUpdateFiles];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
//------------------------------------------------------------------------------------
+(NSDate*)lastUpdateDateForKey:(NSString*)key
{
    NSDictionary *allFoldersDictionary = [[NSUserDefaults standardUserDefaults] objectForKey:kLastUpdateFiles];
    if(!allFoldersDictionary)
        return nil;
    
    NSDictionary *foldersDictionary = [allFoldersDictionary objectForKey:rootFolderName];
    if(!foldersDictionary)
        return nil;
    
    return [foldersDictionary objectForKey:key];
}
//------------------------------------------------------------------------------------
+(void)removeDateForKey:(NSString*)key
{
    @synchronized(self) {
        NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:kLastUpdateFiles];
        NSMutableDictionary *allFoldersDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
        if(dic)
            [allFoldersDictionary setDictionary:dic];
        else return;
        
        NSMutableDictionary *folderDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
        if([allFoldersDictionary objectForKey:rootFolderName]){
            [folderDictionary setDictionary:[allFoldersDictionary objectForKey:rootFolderName]];
        }else return;
        
        [folderDictionary removeObjectForKey:key];
        [allFoldersDictionary setObject:folderDictionary forKey:rootFolderName];
        [[NSUserDefaults standardUserDefaults] setObject:allFoldersDictionary forKey:kLastUpdateFiles];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
//------------------------------------------------------------------------------------

@end
