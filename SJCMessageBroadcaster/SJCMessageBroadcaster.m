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

#import "SJCMessageBroadcaster.h"

NSString *const SJCMessageBroadcasterNotification = @"SJCMessageBroadcasterNotification";

SJCMessageBroadcaster *shared = nil;

@interface SJCMessageBroadcaster () {
    NSMutableArray *_messages;
    NSTimer *_timer;
}

- (void)broadcastNextMessage;

@end

@implementation SJCMessageBroadcaster

+ (instancetype)shared {
    if(nil == shared) {
        shared = [SJCMessageBroadcaster new];
    }
    return shared;
}

- (id)init {
    if((self = [super init])) {
        _duration = 5.0f;
        _messages = [NSMutableArray new];
    }
    return self;
}

- (void)setDuration:(NSTimeInterval)duration {
    if(duration > 0.0) { _duration = duration; }
}

- (void)broadcastMessages:(NSArray *)messages {

    @synchronized(self) {
        
        NSMutableArray *msgs = [NSMutableArray arrayWithCapacity: messages.count];
        for(id string in messages) {
            if([string isKindOfClass: [NSString class]]) {
                [msgs addObject: string];
#ifdef DEBUG
            } else {
                [NSException raise: NSInvalidArgumentException format: @"Non-string passed to -broadcastMessages: %@", string];
#endif
            }
        }
        
        if(0 == msgs.count) { return; }
        
        if((nil == _currentMessage) && (0 == _messages.count)) {
            // if no message is currently displayed or queued for display, start displaying them
            dispatch_async(dispatch_get_main_queue(), ^{
                [self broadcastNextMessage];
            });
        }

        [_messages addObjectsFromArray: msgs];

    }
}

- (void)broadcastNextMessage {
    
    @synchronized(self) {
        
        _currentMessage = _messages.firstObject;
    
        // broadcast even if message == nil to clear navigation bar prompts
        [[NSNotificationCenter defaultCenter] postNotificationName: SJCMessageBroadcasterNotification
                                                            object: _currentMessage];

        if(nil != _currentMessage) {
            // remove the message we've just displayed
            [_messages removeObjectAtIndex: 0];
            
            // schedule display of the next one
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, _duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^(void){
                [self broadcastNextMessage];
            });
        }
        
    }
}

@end
