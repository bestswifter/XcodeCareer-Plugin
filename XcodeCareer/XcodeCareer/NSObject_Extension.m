//
//  NSObject_Extension.m
//  XcodeCareer
//
//  Created by KT on 6/1/15.
//  Copyright (c) 2015 KT. All rights reserved.
//


#import "NSObject_Extension.h"
#import "XcodeCareer.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[XcodeCareer alloc] initWithBundle:plugin];
        });
    }
}
@end
