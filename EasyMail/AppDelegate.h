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
#import "PersonEmailPair.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSWindowDelegate, GrowlApplicationBridgeDelegate> {
  NSMutableDictionary *config;
}

@property (assign) IBOutlet NSApplication *app;
@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTableView *filesTable;
@property (assign) IBOutlet NSTokenField *sendToField;
@property (assign) IBOutlet NSTextField *subjectField;
@property (assign) IBOutlet NSButton *sendButton;
@property (assign) IBOutlet FilesDataSource *filesDataSource;
@property (assign) IBOutlet NSProgressIndicator *progressIndicator;
@property (assign) IBOutlet NSMenuItem *sendMenuItem;

- (IBAction)doSend:(id)sender;

@end
