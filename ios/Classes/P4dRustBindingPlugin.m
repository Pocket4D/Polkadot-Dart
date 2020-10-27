#import "P4dRustBindingPlugin.h"
#if __has_include(<p4d_rust_binding/p4d_rust_binding-Swift.h>)
#import <p4d_rust_binding/p4d_rust_binding-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "p4d_rust_binding-Swift.h"
#endif

@implementation P4dRustBindingPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftP4dRustBindingPlugin registerWithRegistrar:registrar];
}
@end
