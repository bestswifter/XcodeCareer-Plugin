//
//  NSString+Transform.m
//  XcodeCareer
//
//  Created by KT on 6/7/15.
//  Copyright (c) 2015 KT. All rights reserved.
//

#import "NSString+Transform.h"

@implementation NSString (Transform)

+ (NSString *)getFormattedWithSeconds:(int)seconds{
    int hours = seconds / 3600;
    seconds = seconds % 3600;
    
    int minutes = seconds / 60;
    seconds = seconds % 60;
    
    if (hours != 0) {
        return [NSString stringWithFormat:@"%d hours %d minutes and %d seconds",hours,minutes,seconds];
    }
    else{
        if (minutes != 0) {
            return [NSString stringWithFormat:@"%d minutes and %d seconds",minutes,seconds];
        }
        else{
            return [NSString stringWithFormat:@"%d seconds",seconds];
        }
    }
}

@end
