//
//  FilesDataSource.m
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "FilesDataSource.h"

@implementation FilesDataSource {
  NSMutableArray *files;
}

- (id)init {
  if (self = [super init]) {
    files = [NSMutableArray array];
  }
  return self;
}

- (void)addFile:(NSString *)path {
  NSFileManager *fileManager = [NSFileManager defaultManager];
  BOOL isDir;
  if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && !isDir) {
    [files addObject:path];
  };
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
  return [files count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
  return [files objectAtIndex:row];
}

- (NSArray *)files {
  return files;
}

@end
