//
//  PreferencesController.m
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/30/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "PreferencesController.h"

@implementation PreferencesController

@synthesize emailInput;
@synthesize passwordInput;
@synthesize textInput;

- (id)initWithWindow:(NSWindow *)window {
  if (self = [super initWithWindow:window]) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(savePreferences:)
                                                 name:NSWindowWillCloseNotification
                                               object:self.window];    
  }
  return self;
}

- (void)showPreferences:(id)sender {
  [NSApp runModalForWindow:self.window];
}

- (void)savePreferences:(id)sender {
  [NSApp stopModal];
  [Config setObject:[emailInput stringValue] forKey:@"email"];
  [Config setObject:[passwordInput stringValue] forKey:@"password"];
  [Config setObject:[textInput stringValue] forKey:@"text"];
  [Config saveConfig];
}

- (void)windowDidLoad {
  [super windowDidLoad];
  [emailInput setObjectValue:[Config objectFor:@"email"]];
  [passwordInput setObjectValue:[Config objectFor:@"password"]];
  [textInput setObjectValue:[Config objectFor:@"text"]];
}

@end
