#import "GameCenterPlugin.h"
#import <gamecenter/gamecenter-Swift.h>

@implementation GameCenterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftGameCenterPlugin registerWithRegistrar:registrar];
}
@end
