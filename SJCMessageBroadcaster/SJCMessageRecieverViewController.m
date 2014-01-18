/*
 The MIT License (MIT)
 
 Copyright (c) 2014 Stuart Crook
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of
 this software and associated documentation files (the "Software"), to deal in
 the Software without restriction, including without limitation the rights to
 use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
 the Software, and to permit persons to whom the Software is furnished to do so,
 subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
 FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
 COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
 IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
 CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "SJCMessageRecieverViewController.h"
#import "SJCMessageBroadcaster.h"

@interface SJCMessageRecieverViewController ()
- (void)messageBroadcastNotification:(NSNotification *)note;
@end

@implementation SJCMessageRecieverViewController

- (id)init {
    if((self = [super init])) {
        // add an observer to listen for broadcast messages
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(messageBroadcastNotification:)
                                                     name: SJCMessageBroadcasterNotification
                                                   object: nil];
        
        // set the navigation bar's prompt to the current message before the bar is shown
        self.navigationItem.prompt = [SJCMessageBroadcaster shared].currentMessage;
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver: self];
}

// update the message shown in the navigation bar prompt space
- (void)messageBroadcastNotification:(NSNotification *)note {
    self.navigationItem.prompt = note.object;
}

@end
