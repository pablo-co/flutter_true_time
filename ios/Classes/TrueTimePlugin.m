#import "TrueTimePlugin.h"
#if __has_include(<true_time/true_time-Swift.h>)
#import <true_time/true_time-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "true_time-Swift.h"
#endif

@implementation TrueTimePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTrueTimePlugin registerWithRegistrar:registrar];
}
@end
