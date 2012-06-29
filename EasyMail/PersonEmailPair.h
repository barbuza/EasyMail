//
//  PersonEmailPair.h
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonEmailPair : NSObject

@property (strong) NSString *email;
@property (strong) NSString *name;

+ (id)pairForName:(NSString *)aName email:(NSString *)anEmail;
- (id)initWithName:(NSString *)name email:(NSString *)email;

@end
