#import "FlutterIosSideMenuPlugin.h"
#import <side_menu_scaffold/side_menu_scaffold-Swift.h>

@implementation FlutterIosSideMenuPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterIosSideMenuPlugin registerWithRegistrar:registrar];
}
@end
