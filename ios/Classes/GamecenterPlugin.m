#import "GamecenterPlugin.h"
#import <gamecenter/gamecenter-Swift.h>

@implementation GamecenterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGamecenterPlugin registerWithRegistrar:registrar];
}
@end
