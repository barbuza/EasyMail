//
//  EasyMailPrefs.m
//  EasyMailPrefs
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "EasyMailPrefs.h"

static NSString *configPath() {
  NSFileManager *fileManaged = [NSFileManager defaultManager];
  NSString *configDir = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"EasyMail"];
  [fileManaged createDirectoryAtPath:configDir withIntermediateDirectories:YES attributes:nil error:nil];
  return [configDir stringByAppendingPathComponent:@"config.plist"];
};

static NSMutableDictionary *loadConfig() {
  NSMutableDictionary *config = [NSMutableDictionary dictionaryWithContentsOfFile:configPath()];
  if (config == nil) config = [NSMutableDictionary dictionary];
  return config;
}


@implementation EasyMailPrefs

@synthesize usernameInput;
@synthesize passwordInput;
@synthesize textInput;

- (void)mainViewDidLoad {
  NSDictionary *config = loadConfig();
  NSString *email = [config objectForKey:@"email"];
  if (email != nil) [usernameInput setStringValue:email];
  NSString *password = [config objectForKey:@"password"];
  if (password != nil) [passwordInput setStringValue:password];
  NSString *text = [config objectForKey:@"text"];
  if (text != nil) [textInput setStringValue:text];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(doSave:)
                                               name:NSApplicationWillTerminateNotification
                                             object:nil];
}

- (IBAction)doSave:(id)sender {
  NSMutableDictionary *config = loadConfig();
  [config setObject:[usernameInput stringValue] forKey:@"email"];
  [config setObject:[passwordInput stringValue] forKey:@"password"];
  [config setObject:[textInput stringValue] forKey:@"text"];
  [config writeToFile:configPath() atomically:YES];
}


@end
