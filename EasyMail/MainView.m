//
//  MainView.m
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "MainView.h"

@implementation MainView {
  BOOL hightlighted;
}

@synthesize filesDataSource;
@synthesize filesTable;

- (id)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super initWithCoder:aDecoder]) {
    hightlighted = NO;
    [self registerForDraggedTypes:@[NSFilenamesPboardType]];
  }
  return self;
}

- (NSDragOperation)draggingEntered:(id<NSDraggingInfo>)sender {
  [self setHighlighted:YES];
  return NSDragOperationCopy;
}

- (void)drawRect:(NSRect)dirtyRect {
  if (hightlighted) {
    [[NSColor whiteColor] setFill];
    NSRectFill([self bounds]);
  }
}

- (void)setHighlighted:(BOOL)value {
  hightlighted = value;
  [self setNeedsDisplay:YES];
}

- (void)draggingExited:(id<NSDraggingInfo>)sender {
  [self setHighlighted:NO];
}

- (void)draggingEnded:(id<NSDraggingInfo>)sender {
  CGPoint point = [sender draggingLocation];
  NSRect bounds = [self bounds];
  if (point.x > bounds.origin.x && point.x < bounds.size.width && point.y > bounds.origin.y && point.y < bounds.size.height) {
    NSPasteboard *paste = [sender draggingPasteboard];
    [[paste pasteboardItems] enumerateObjectsUsingBlock:^(NSPasteboardItem *item, NSUInteger idx, BOOL *stop) {
      NSString *url = [item stringForType:@"public.file-url"];
      if (url != nil) {
        [self.filesDataSource addFile:[[NSURL URLWithString:url] path]];
      }
    }];
    [self.filesTable reloadData];
  }
  [self setHighlighted:NO];
}

@end
