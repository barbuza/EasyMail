//
//  Config.m
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/30/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "Config.h"


@implementation Config

+ (NSMutableDictionary *)mutableConfigDict {
  static NSMutableDictionary *config;
  if (config == nil) {
    config = [NSMutableDictionary dictionaryWithContentsOfFile:[Config configPath]];
    if (config == nil) {
      config = [NSMutableDictionary dictionary];
    }
  }
  return config;
}

+ (NSString *)configPath {
  static NSString *configPath;
  if (configPath == nil) {
    NSString *configDir = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"EasyMail"];
    NSFileManager *fileManaged = [NSFileManager defaultManager];
    [fileManaged createDirectoryAtPath:configDir withIntermediateDirectories:YES attributes:nil error:nil];
    configPath = [configDir stringByAppendingPathComponent:@"config.plist"];
  }
  return configPath;
}

+ (void)saveConfig {
  [[Config mutableConfigDict] writeToFile:[Config configPath] atomically:YES];
}

+ (id)objectFor:(NSString *)key {
  return [[Config mutableConfigDict] objectForKey:key];
}

+ (id)objectFor:(NSString *)key withDefault:(id)object {
  id obj = [Config objectFor:key];
  if (obj == nil) {
    obj = object;
  }
  return obj;
}

+ (void)setObject:(id)object forKey:(NSString *)key {
  [[Config mutableConfigDict] setObject:object forKey:key];
}

+ (BOOL)hasObjectFor:(NSString *)key {
  return [Config objectFor:key] != nil;
}

+ (BOOL)hasNonEmptyObjectFor:(NSString *)key {
  id object = [Config objectFor:key];
  if (object != nil) {
    if ([object isKindOfClass:[NSString class]]) {
      return !! [object length];
    } else if ([object isKindOfClass:[NSArray class]]) {
      return !! [object count];
    } else if ([object isKindOfClass:[NSDictionary class]]) {
      return !! [object count];
    }
  }
  return NO;
}

+ (BOOL)hasObjectsFor:(NSArray *)keys {
  return [[keys indexesOfObjectsPassingTest:^(NSString *key, NSUInteger idx, BOOL *stop) {
    return [Config hasObjectFor:key];
  }] count] == [keys count];
}

+ (BOOL)hasNonEmptyObjectsFor:(NSArray *)keys {
  return [[keys indexesOfObjectsPassingTest:^(NSString *key, NSUInteger idx, BOOL *stop) {
    return [Config hasNonEmptyObjectFor:key];
  }] count] == [keys count];
}

@end
