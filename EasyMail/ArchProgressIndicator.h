//
//  ArchProgressIndicator.h
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/30/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ArchProgressIndicator : NSProgressIndicator {
@private
  NSTimer * animationTimer;
}

@end
