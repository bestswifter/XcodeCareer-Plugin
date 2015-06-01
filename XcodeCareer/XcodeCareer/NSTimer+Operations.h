//
//  NSTimer+Operations.h
//  XcodeCareer
//
//  Created by KT on 5/31/15.
//  Copyright (c) 2015 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Operations)

- (void)pause;
- (void)recover;
- (void)recoverAndStartImmediately;
- (void)recoverWithInterval:(NSTimeInterval)ti;
- (BOOL)isPaused;


@end
