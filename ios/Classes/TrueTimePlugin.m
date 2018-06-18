#import "TrueTimePlugin.h"
#import <true_time/true_time-Swift.h>

@implementation TrueTimePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTrueTimePlugin registerWithRegistrar:registrar];
}
@end
