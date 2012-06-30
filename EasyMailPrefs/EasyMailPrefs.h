//
//  EasyMailPrefs.h
//  EasyMailPrefs
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>

@interface EasyMailPrefs : NSPreferencePane

@property (assign) IBOutlet NSTextField *usernameInput;
@property (assign) IBOutlet NSSecureTextField *passwordInput;
@property (assign) IBOutlet NSTextField *textInput;

- (void)mainViewDidLoad;
- (IBAction)doSave:(id)sender;

@end
