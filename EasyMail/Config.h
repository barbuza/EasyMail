//
//  Config.h
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/30/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Config : NSObject

+ (NSMutableDictionary *)mutableConfigDict;
+ (NSString *)configPath;
+ (void)saveConfig;
+ (id)objectFor:(NSString *)key;
+ (id)objectFor:(NSString *)key withDefault:(id)object;
+ (void)setObject:(id)object forKey:(NSString *)key;
+ (BOOL)hasObjectFor:(NSString *)key;
+ (BOOL)hasNonEmptyObjectFor:(NSString *)key;
+ (BOOL)hasObjectsFor:(NSArray *)keys;
+ (BOOL)hasNonEmptyObjectsFor:(NSArray *)keys;

@end
