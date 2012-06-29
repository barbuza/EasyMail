//
//  PrefPane.h
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PrefPane : NSObject

@property (assign) IBOutlet NSTextField *usernameInput;
@property (assign) IBOutlet NSSecureTextField *passwordInput;
@property (assign) IBOutlet NSTextField *textInput;

- (void)loadInitial;

- (IBAction)doSave:(id)sender;

@end
