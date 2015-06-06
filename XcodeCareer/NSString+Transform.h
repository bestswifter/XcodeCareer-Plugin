//
//  NSString+Transform.h
//  XcodeCareer
//
//  Created by KT on 6/7/15.
//  Copyright (c) 2015 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Transform)

/**
 *  Get the formatted string
 *
 *  @param seconds the total seconds
 *
 *  @return String like "3 hours 5 minutes and 4 seconds"
 */
+ (NSString *)getFormattedWithSeconds:(int)seconds;

@end
