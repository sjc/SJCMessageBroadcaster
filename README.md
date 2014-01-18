SJCMessageBroadcaster
=====================

Display messages in the navigation bar prompts of all view controllers in an app.

A little something I needed in a project I was working on, which I hoped might come in useful for others. The example app shows the same messages being displayed even as you tab between different view controllers.

To use:

1. Copy the "SJCMessagesBroadcaster" folder into your Xcode project.

2. Either have your UIViewController subclasses inherit from "SJCMessageRecieverViewController", or copy the code from that class either into a shared UIViewController superclass or individually into each view controller class you want to be able to display messages.

3. Send messages by invoking -broadcastMessages: on the shared instance of SJCMessageBroadcaster with an array of NSStrings.
