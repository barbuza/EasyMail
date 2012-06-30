//
//  AppDelegate.m
//  EasyMail
//
//  Created by Viktor Kotseruba on 6/29/12.
//  Copyright (c) 2012 Viktor Kotseruba. All rights reserved.
//

#import "AppDelegate.h"

static NSString *configPath() {
  NSString *configDir = [[NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"EasyMail"];
  NSFileManager *fileManaged = [NSFileManager defaultManager];
  [fileManaged createDirectoryAtPath:configDir withIntermediateDirectories:YES attributes:nil error:nil];
  return [configDir stringByAppendingPathComponent:@"config.plist"];
};

static NSMutableDictionary *loadConfig() {
  return [NSMutableDictionary dictionaryWithContentsOfFile:configPath()];
};

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
@synthesize sendMenuItem;

- (NSDictionary *)registrationDictionaryForGrowl {
  return @{GROWL_NOTIFICATIONS_ALL : @[@"sending", @"sent"], GROWL_NOTIFICATIONS_DEFAULT : @[@"sending", @"sent"]};
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  [GrowlApplicationBridge setGrowlDelegate:self];
  config = loadConfig();
  if ([config objectForKey:@"email"] == nil || [config objectForKey:@"password"] == nil) {
    [[NSAlert alertWithMessageText:@"EasyMail is not configured"
                     defaultButton:nil
                   alternateButton:nil
                       otherButton:nil
         informativeTextWithFormat:@""] runModal];
    exit(1);
  }
  NSArray *recipients = [config objectForKey:@"recipients"];
  if ([recipients count]) {
    [sendToField setObjectValue:recipients];
    [subjectField becomeFirstResponder];
  }
  NSString *subject = [config objectForKey:@"subject"];
  if (subject != nil) [subjectField setStringValue:subject];
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
  
  sending = YES;
  
  [sendToField setEnabled:NO];
  [subjectField setEnabled:NO];
  [sendButton setEnabled:NO];
  [sendMenuItem setEnabled:NO];
  [progressIndicator startAnimation:sender];

  NSMutableArray *emails = [NSMutableArray array];
  [[sendToField objectValue] enumerateObjectsUsingBlock:^(NSDictionary *recipient, NSUInteger idx, BOOL *stop) {
    [emails addObject:[recipient objectForKey:@"email"]];
  }];
  NSArray *recipients = [NSArray arrayWithArray:[sendToField objectValue]];
  
  NSString *text = [config objectForKey:@"text"];
  if (text == nil) text = @"EasyMail delivery";
  
  
  NSArray *files = [filesDataSource files];
  NSUInteger filesCount = [files count];
  NSUInteger emailsCount = [emails count];
  NSString *filesCountString = (filesCount == 1) ? @"file" : @"files";
  NSString *personsCountString = (emailsCount == 1) ? @"person" : @"persons";
  NSString *subject = [subjectField stringValue];
  
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
    int failure = [PythonMail sendMessageFrom:[config objectForKey:@"email"]
                                     password:[config objectForKey:@"password"]
                                      subject:subject
                                         text:text
                                   recipients:emails
                                  attachments:files];
    [config setObject:recipients forKey:@"recipients"];
    [config setObject:subject forKey:@"subject"];
    [config writeToFile:configPath() atomically:YES];
    
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

@end
