//
//  AppDelegate.h
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PythonMail.h"
#import "FilesDataSource.h"
#import "PreferencesController.h"
#import "Config.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate, GrowlApplicationBridgeDelegate>

@property (assign) IBOutlet NSApplication *app;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableView *filesTable;
@property (assign) IBOutlet NSTokenField *sendToField;
@property (assign) IBOutlet NSTextField *subjectField;
@property (assign) IBOutlet NSButton *sendButton;
@property (assign) IBOutlet FilesDataSource *filesDataSource;
@property (assign) IBOutlet NSProgressIndicator *progressIndicator;

- (IBAction)doSend:(id)sender;
- (IBAction)showPreferences:(id)sender;

@end
