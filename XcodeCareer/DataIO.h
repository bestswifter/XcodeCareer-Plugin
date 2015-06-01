//
//  DataIO.h
//  XcodeCareer
//
//  Created by KT on 5/31/15.
//  Copyright (c) 2015 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataIO : NSObject

@property (nonatomic,strong) NSNumber *TotalSeconds;
@property (nonatomic,strong) NSNumber *TotalLines;

- (id)init;
- (void)writeIntoFile;

@end
