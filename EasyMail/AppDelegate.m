//
//  AppDelegate.m
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate {
  BOOL sending;
}

@synthesize app;
@synthesize window;
@synthesize filesTable;
@synthesize sendToField;
@synthesize subjectField;
@synthesize filesDataSource;
@synthesize sendButton;
@synthesize progressIndicator;

- (NSDictionary *)registrationDictionaryForGrowl {
  return @{GROWL_NOTIFICATIONS_ALL : @[@"sending", @"sent"], GROWL_NOTIFICATIONS_DEFAULT : @[@"sending", @"sent"]};
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [GrowlApplicationBridge setGrowlDelegate:self];
  
  if (! [Config hasNonEmptyObjectsFor:@[@"email", @"password", @"text"]]) {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
      [self showPreferences:nil];
    });
  }
  
  if ([Config hasNonEmptyObjectFor:@"recipients"]) {
    [sendToField setObjectValue:[Config objectFor:@"recipients"]];
    [subjectField becomeFirstResponder];
  }
  
  if ([Config hasNonEmptyObjectFor:@"subject"]) {
    [subjectField setStringValue:[Config objectFor:@"subject"]];
  }
}

- (void)application:(NSApplication *)sender openFiles:(NSArray *)filenames {
  [filenames enumerateObjectsUsingBlock:^(NSString *filename, NSUInteger idx, BOOL *stop) {
    [filesDataSource addFile:filename];
  }];
  [filesTable reloadData];
}

- (IBAction)doSend:(id)sender {
  if (sending) return;
  if (! [[filesDataSource files] count]) return;
  if (! [[sendToField objectValue] count]) return;
  if (! [[subjectField stringValue] length]) return;
  
  sending = YES;
  
  [sendToField setEnabled:NO];
  [subjectField setEnabled:NO];
  [sendButton setEnabled:NO];
  [progressIndicator startAnimation:sender];
  
  NSMutableArray *emails = [NSMutableArray array];
  [[sendToField objectValue] enumerateObjectsUsingBlock:^(NSDictionary *recipient, NSUInteger idx, BOOL *stop) {
    [emails addObject:[recipient objectForKey:@"email"]];
  }];
  NSArray *recipients = [NSArray arrayWithArray:[sendToField objectValue]];
  
  NSString *text = [Config objectFor:@"text"];
  if (text == nil) {
    text = @"EasyMail delivery";
  }
  
  
  NSArray *files = [filesDataSource files];
  NSUInteger filesCount = [files count];
  NSUInteger emailsCount = [emails count];
  NSString *filesCountString = (filesCount == 1) ? @"file" : @"files";
  NSString *personsCountString = (emailsCount == 1) ? @"person" : @"persons";
  NSString *subject = [subjectField stringValue];
  
  [Config setObject:recipients forKey:@"recipients"];
  [Config setObject:subject forKey:@"subject"];
  [Config saveConfig];
  
  NSString *notificationText = [NSString stringWithFormat:@"sending %li %@ to %li %@", filesCount, filesCountString, emailsCount, personsCountString];
  [GrowlApplicationBridge notifyWithTitle:@"EasyMail"
                              description:notificationText
                         notificationName:@"sending"
                                 iconData:nil
                                 priority:0
                                 isSticky:NO
                             clickContext:nil];
  
  
  dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_async(queue, ^{
    
    int failure = [PythonMail sendMessageFrom:[Config objectFor:@"email"]
                                     password:[Config objectFor:@"password"]
                                      subject:subject
                                         text:text
                                   recipients:emails
                                  attachments:files];
    
    if (! failure) {
      [GrowlApplicationBridge notifyWithTitle:@"EasyMail"
                                  description:@"done"
                             notificationName:@"sent"
                                     iconData:nil
                                     priority:0
                                     isSticky:NO
                                 clickContext:nil];
    }
    
    [progressIndicator stopAnimation:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC), queue, ^(void){
      [app terminate:nil];
    });
    
  });
}

- (void)windowWillClose:(NSNotification *)notification {
  [app terminate:self];
}

- (void)showPreferences:(id)sender {
  NSLog(@"show preferences");
  PreferencesController *controller = [[PreferencesController alloc] initWithWindowNibName:@"Preferences"];
  [controller showPreferences:nil];
}

@end
