//
//  EasyMailPrefs.m
//  EasyMailPrefs
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "EasyMailPrefs.h"

@implementation EasyMailPrefs

@synthesize prefPane;

- (void)mainViewDidLoad {
  [prefPane loadInitial];
}

@end
