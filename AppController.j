/*
 * AppController.j
 * Notifications
 *
 * Created by You on June 11, 2013.
 * Copyright 2013, Your Company All rights reserved.
 */

@import <Foundation/Foundation.j>
@import <AppKit/AppKit.j>


@implementation AppController : CPObject
{
    @outlet CPWindow    theWindow;
}

- (void)applicationDidFinishLaunching:(CPNotification)aNotification
{
    // This is called when the application is done loading.
}

- (void)awakeFromCib
{
    // This is called when the cib is done loading.
    // You can implement this method on any object instantiated from a Cib.
    // It's a useful hook for setting up current UI values, and other things.

    // In this case, we want the window from Cib to become our full browser window
    [theWindow setFullPlatformWindow:YES];
}

-(@action)registerForNotification:(id)sender {
    console.log("register for Notification");
    [[CPNotificationCenter defaultCenter]
        addObserver:self
        selector:@selector(handleNotification:)
        name:"MyNotification"
        object:nil];
}

-(@action)unregisterForNotification:(id)sender {
    console.log("unregister for Notification");
    [[CPNotificationCenter defaultCenter] removeObserver:self];
}

- (@action)sendNotification:(id)sender {
    [[CPNotificationCenter defaultCenter]
        postNotificationName:@"MyNotification"
        object:"Message from notification"];
}
 
-(void)handleNotification:(CPNotification)pNotification
{
    console.log("received notification message = " + [pNotification object]);
}

@end
