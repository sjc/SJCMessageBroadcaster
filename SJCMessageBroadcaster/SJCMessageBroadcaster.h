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

// Broadcasts messages to be displayed in the navigation bar prompt spaces of
// each view controller (which has inherited from SJCMessageRecieverViewController
// or otherwise implemented the necessary code) in your app

#import <Foundation/Foundation.h>

extern NSString *const SJCMessageBroadcasterNotification;

@interface SJCMessageBroadcaster : NSObject

+ (instancetype)shared;

/// sets the length of time for which messages will be displayed
@property (nonatomic) NSTimeInterval duration;

/// returns the message which is currently being displayed (5 seconds by default) or nil
@property (nonatomic,readonly) NSString *currentMessage;

/// sets the messages to be displayed, as NSStrings. any non-strings will cause exceptions if $DEBUG, and otherwise be quietly discarded
- (void)broadcastMessages:(NSArray *)messages;

@end
