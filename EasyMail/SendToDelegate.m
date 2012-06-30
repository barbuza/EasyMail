//
//  SendToDelegate.m
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "SendToDelegate.h"

@implementation SendToDelegate

- (NSArray *)tokenField:(NSTokenField *)tokenField
completionsForSubstring:(NSString *)substring
           indexOfToken:(NSInteger)tokenIndex
    indexOfSelectedItem:(NSInteger *)selectedIndex
{
  ABAddressBook *book = [ABAddressBook sharedAddressBook];
  ABSearchElement *search = [ABPerson searchElementForProperty:kABEmailProperty
                                                         label:nil
                                                           key:nil
                                                         value:substring
                                                    comparison:kABPrefixMatchCaseInsensitive];
  NSArray *people = [book recordsMatchingSearchElement:search];
  NSMutableArray *emails = [NSMutableArray array];
  [people enumerateObjectsUsingBlock:^(ABPerson *person, NSUInteger idx, BOOL *stop) {
    ABMultiValue *personEmails = [person valueForProperty:kABEmailProperty];
    for (NSUInteger i = 0; i < [personEmails count]; i++) {
      NSString *email = [personEmails valueAtIndex:i];
      if (! [emails containsObject:email]) {
        if (! [email hasSuffix:@"@facebook.com"]) {
          [emails addObject:email];
        }
      }
    }
  }];
  return emails;
}

- (id)tokenField:(NSTokenField *)tokenField
representedObjectForEditingString:(NSString *)editingString
{
  ABAddressBook *book = [ABAddressBook sharedAddressBook];
  ABSearchElement *search = [ABPerson searchElementForProperty:kABEmailProperty
                                                         label:nil
                                                           key:nil
                                                         value:editingString
                                                    comparison:kABEqualCaseInsensitive];
  NSArray *people = [book recordsMatchingSearchElement:search];
  NSString *name = editingString;
  if ([people count]) {
    ABPerson *person = [people objectAtIndex:0];
    NSString *firstName = [person valueForProperty:kABFirstNameProperty];
    NSString *lastName = [person valueForProperty:kABLastNameProperty];
    name = [NSString stringWithFormat:@"%@ %@", firstName, lastName];
  }
  return @{@"email" : editingString, @"name": name};
}

- (NSString *)tokenField:(NSTokenField *)tokenField
displayStringForRepresentedObject:(id)representedObject
{
  return [representedObject objectForKey:@"name"];
}

@end
