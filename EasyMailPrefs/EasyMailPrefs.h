//
//  EasyMailPrefs.h
//  EasyMailPrefs
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <PreferencePanes/PreferencePanes.h>
#import "PrefPane.h"

@interface EasyMailPrefs : NSPreferencePane

@property (assign) IBOutlet PrefPane *prefPane;

- (void)mainViewDidLoad;

@end
