//
//  NSTimer+Operations.m
//  XcodeCareer
//
//  Created by KT on 5/31/15.
//  Copyright (c) 2015 KT. All rights reserved.
//

#import "NSTimer+Operations.h"

@implementation NSTimer (Operations)

- (void)pause{
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:LongLongTimeLater]];
}

- (void)recover{
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:DefaultRecoverInterval]];
}

- (void)recoverAndStartImmediately{
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:0]];
}

- (void)recoverWithInterval:(NSTimeInterval)ti{
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:ti]];
}

- (BOOL)isPaused{
    NSTimeInterval intervalSinceNow = [self.fireDate timeIntervalSinceNow];
    return intervalSinceNow > LongLongTimeLater/12;
}

@end
