//
//  ArchProgressIndicator.m
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/30/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "ArchProgressIndicator.h"

@interface ArchProgressIndicator ()

@property (strong) NSTimer * animationTimer;

@end


@implementation ArchProgressIndicator

@synthesize animationTimer;

- (void)addObserver {
  [self addObserver:self forKeyPath:@"animationTimer" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
            context:(__bridge void *)([ArchProgressIndicator class])];
}

- (id)initWithFrame:(NSRect)frameRect {
  if ((self = [super initWithFrame:frameRect])) {
    [self addObserver];
  }
  
  return self;
}

// -initWithFrame: may not be called if created by a nib file
- (void)awakeFromNib {
  [self addObserver];
}

// Documentation lists this as the default for -animationDelay
static const NSTimeInterval ANIMATION_UPDATE_INTERVAL = 5.0/60.0;

- (void)startAnimation:(id)sender {
  [super startAnimation:sender];
  
  if([self layer]) {
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:ANIMATION_UPDATE_INTERVAL target:self selector:@selector(animate:) userInfo:nil repeats:YES];
  }
}

- (void)stopAnimation:(id)sender {
  self.animationTimer = nil;
  
  [super stopAnimation:sender];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if(context == (__bridge void *)[ArchProgressIndicator class]) {
    if([keyPath isEqual:@"animationTimer"]) {
      if([change objectForKey:NSKeyValueChangeOldKey] != [NSNull null] && [change objectForKey:NSKeyValueChangeOldKey] != [change objectForKey:NSKeyValueChangeNewKey]) {
        [[change objectForKey:NSKeyValueChangeOldKey] invalidate];
      }
    }
  }
  else {
    return [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

- (void)dealloc {
  [self removeObserver:self forKeyPath:@"animationTimer"];
  [animationTimer invalidate];
}

@end