//
//  MainView.h
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FilesDataSource.h"

@interface MainView : NSView

@property (assign) IBOutlet FilesDataSource *filesDataSource;
@property (assign) IBOutlet NSTableView *filesTable;

@end
