//
//  PythonMail.h
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PythonMail : NSObject

+ (int)sendMessageFrom:(NSString *)account
              password:(NSString *)password
               subject:(NSString *)subject
                  text:(NSString *)text
            recipients:(NSArray *)recipients
           attachments:(NSArray *)attachments;

@end
