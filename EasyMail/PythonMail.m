//
//  PythonMail.m
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "PythonMail.h"

@implementation PythonMail

+ (int)sendMessageFrom:(NSString *)account
              password:(NSString *)password
               subject:(NSString *)subject
                  text:(NSString *)text
            recipients:(NSArray *)recipients
           attachments:(NSArray *)attachments
{
  NSArray *jsonData = @[account, password, recipients, subject, text, attachments];
  NSURL *codePath = [[NSURL URLWithString:[[NSBundle mainBundle] resourcePath]] URLByAppendingPathComponent:@"mail.py"];
  NSString *pythonCode = [NSString stringWithContentsOfFile:[codePath absoluteString] encoding:NSUTF8StringEncoding error:nil];
  pythonCode = [pythonCode stringByReplacingOccurrencesOfString:@"OBJC_MESSAGE" withString:[jsonData JSONRepresentation]];
  Py_Initialize();
  int failure = PyRun_SimpleString([pythonCode UTF8String]);
  Py_Finalize();
  if (failure) {
    [[NSAlert alertWithMessageText:@"send failure"
                     defaultButton:nil
                   alternateButton:nil
                       otherButton:nil
         informativeTextWithFormat:@""] runModal];
  }
  return failure;
}

@end
