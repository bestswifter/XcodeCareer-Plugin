//
//  DataIO.m
//  XcodeCareer
//
//  Created by KT on 5/31/15.
//  Copyright (c) 2015 KT. All rights reserved.
//

#import "DataIO.h"

@implementation DataIO

- (id)init{
    self = [super init];
    if (self) {
        NSDictionary *statistics = [self getDictionaryFromFile];
        /**
         *  Check whether the BeginDate is nil. If so, take current date as the BeginDate
         */
        NSString *beginDate = [statistics objectForKey:@"BeginDate"];
        if (!beginDate || beginDate.length == 0) {
            NSString *currentDate = [self stringFromDate:[NSDate date]];
            [statistics setValue:currentDate forKey:@"BeginDate"];
            [statistics writeToFile:[self getStatisticsPlistPath] atomically:YES];
        }
        /**
         *  Load data from plist file
         */
        self.TotalLines = [statistics objectForKey:@"TotalLines"];
        self.TotalSeconds = [statistics objectForKey:@"TotalSeconds"];
    }
    return self;
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

- (NSDictionary *)getDictionaryFromFile{
    NSDictionary *statistics = [[NSDictionary alloc]initWithContentsOfFile:[self getStatisticsPlistPath]];
    return statistics;
}

- (NSString *)getStatisticsPlistPath{
    NSArray *appSupportDirectory = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    NSString *supportDir = [appSupportDirectory objectAtIndex:0];
    NSString *plistFilePath = [supportDir stringByAppendingPathComponent:PlistFileSuffix];
    return plistFilePath;
}

- (void)writeIntoFile{
    NSDictionary *statistics = [self getDictionaryFromFile];
    [statistics setValue:self.TotalLines forKey:@"TotalLines"];
    [statistics setValue:self.TotalSeconds forKey:@"TotalSeconds"];
    [statistics writeToFile:[self getStatisticsPlistPath] atomically:YES];
}

@end
