//
//  PreferencesController.h
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/30/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Config.h"

@interface PreferencesController : NSWindowController

@property (assign) IBOutlet NSTextField *emailInput;
@property (assign) IBOutlet NSSecureTextField *passwordInput;
@property (assign) IBOutlet NSTextField *textInput;

- (IBAction)savePreferences:(id)sender;

- (IBAction)showPreferences:(id)sender;

@end
