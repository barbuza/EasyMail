//
//  FilesDataSource.h
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilesDataSource : NSObject <NSTableViewDataSource, NSTableViewDelegate>

- (void)addFile:(NSString *)path;

- (NSArray *)files;

@end
