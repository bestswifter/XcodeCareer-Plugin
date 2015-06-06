//
//  XcodeCareer.m
//  XcodeCareer
//
//  Created by KT on 5/31/15.
//  Copyright (c) 2015 KT. All rights reserved.
//

#import "XcodeCareer.h"
#import "NSTimer+Operations.h"
#import "DataIO.h"
#import "NSString+Transform.h"

@interface XcodeCareer()

@property (nonatomic, strong, readwrite) NSBundle *bundle;

@property (nonatomic) int currentLines;
@property (nonatomic) int previousLines;

@property (nonatomic) int tempIncrease;
@property (nonatomic) int increaseLines;
@property (nonatomic) int seconds;


@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *monitorTimer;
@property (nonatomic, strong) DataIO *data;

@end

@implementation XcodeCareer

@synthesize currentLines,timer,seconds,tempIncrease,increaseLines,previousLines;
@synthesize monitorTimer;
@synthesize data;

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        self.bundle = plugin;
        data = [[DataIO alloc]init];
        
        currentLines = 0;
        tempIncrease = 0;
        previousLines = 0;
        increaseLines = [data.TotalLines intValue];
        seconds = [data.TotalSeconds intValue];
        
        timer = [NSTimer scheduledTimerWithTimeInterval:CheckTextInterval target:self selector:@selector(doEverySecond) userInfo:nil repeats:YES];
        monitorTimer = [NSTimer scheduledTimerWithTimeInterval:CheckIsStillAliveInterval target:self selector:@selector(userDidStopCoding) userInfo:nil repeats:YES];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textStorageDidChange:)
                                                     name:NSTextDidChangeNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textStorageDidFinish:)
                                                     name:NSTextDidEndEditingNotification
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(textStorageDidBegin:)
                                                     name:NSTextDidBeginEditingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
    
    [self addSettingMenu];
}

-(void) addSettingMenu
{
    NSMenuItem *editMenuItem = [[NSApp mainMenu] itemWithTitle:@"Window"];
    if (editMenuItem) {
        [[editMenuItem submenu] addItem:[NSMenuItem separatorItem]];
        
        NSMenuItem *newMenuItem = [[NSMenuItem alloc] initWithTitle:@"EnjoyCoding" action:@selector(showStatistics) keyEquivalent:@"P"];
        [newMenuItem setKeyEquivalentModifierMask:NSShiftKeyMask];
        [newMenuItem setTarget:self];
        [[editMenuItem submenu] addItem:newMenuItem];
    }
}

- (void)showStatistics{
    [self saveStatistics];
    
    NSAlert *alert = [[NSAlert alloc] init];
    NSString *time = [NSString getFormattedWithSeconds:seconds];
    NSString *message = [[NSString alloc]initWithFormat:@"You have written %d lines of codes.\nYou have beening spending %@ in coding.",increaseLines,time];
    [alert setMessageText:message];
    [alert runModal];
}

- (void)textStorageDidChange:(NSNotification *)noti{
    if ([[noti object] isKindOfClass:[NSTextView class]]) {
        NSTextView *textView = (NSTextView *)[noti object];
        if (textView){
            NSArray *a = [textView.textStorage.string componentsSeparatedByString:@"\n"];
            //            NSLog(@"text field lines = %d",(int)[a count] - 1);
            if ([timer isPaused]) {
                [timer recoverAndStartImmediately];
            }
            
            if ((int)[a count] - 1 > 2) {
                currentLines = (int)[a count] - 1;
                tempIncrease = tempIncrease + currentLines - previousLines;
                //                NSLog(@"tempIncrease = %d currentLines = %d previousLines = %d",tempIncrease,currentLines,previousLines);
                previousLines = currentLines;
            }
        }
    }
}

- (void)textStorageDidFinish:(NSNotification *)noti{
    if ([[noti object] isKindOfClass:[NSTextView class]]) {
        NSTextView *textView = (NSTextView *)[noti object];
        if (textView){
            [self saveStatistics];
        }
    }
}

- (void)textStorageDidBegin:(NSNotification *)noti{
    if ([[noti object] isKindOfClass:[NSTextView class]]) {
        NSTextView *textView = (NSTextView *)[noti object];
        NSArray *a = [textView.textStorage.string componentsSeparatedByString:@"\n"];
        currentLines = (int)[a count] - 1;
        previousLines = currentLines;
    }
}

- (void)doEverySecond{
    seconds ++;
}

- (void)userDidStopCoding{
    [timer pause];
}

- (void)saveStatistics{
    //    NSLog(@"save files increase = %d,tempIncrease = %d",increaseLines,tempIncrease);
    increaseLines += tempIncrease;
    tempIncrease = 0;
    
    data.TotalLines = [[NSNumber alloc]initWithInt:increaseLines];
    data.TotalSeconds = [[NSNumber alloc]initWithInt:seconds];
    [data writeIntoFile];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
