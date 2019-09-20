#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.

  FlutterViewController *controller = (FlutterViewController*)self.window.rootViewController;

      FlutterMethodChannel *helloChannel = [FlutterMethodChannel
                                              methodChannelWithName:@"kr.co.deliveryhero/GoogleSheetApi"
                                              binaryMessenger:controller];

      [helloChannel setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
          if ([@"hello" isEqualToString:call.method]) {
              NSLog(@"%@", (NSString *)call.arguments);
              result(@"Hello from Native");
          } else {
              result(FlutterMethodNotImplemented);
          }
      }];

  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
