//
//  XcodeCareer.h
//  XcodeCareer
//
//  Created by KT on 5/31/15.
//  Copyright (c) 2015 KT. All rights reserved.
//

#import <AppKit/AppKit.h>

@class XcodeCareer;

static XcodeCareer *sharedPlugin;

@interface XcodeCareer : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end