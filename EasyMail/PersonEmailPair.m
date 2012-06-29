//
//  PersonEmailPair.m
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "PersonEmailPair.h"

@implementation PersonEmailPair

@synthesize name;
@synthesize email;

- (id)initWithName:(NSString *)aName email:(NSString *)anEmail {
  if (self = [super init]) {
    self.name = aName;
    self.email = anEmail;
  }
  return self;
}

+ (id)pairForName:(NSString *)name email:(NSString *)email {
  return [[PersonEmailPair alloc] initWithName:name email:email];
}

@end
