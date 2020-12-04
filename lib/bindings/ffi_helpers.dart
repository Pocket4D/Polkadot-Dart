import 'dart:ffi';
import 'dart:io' show Platform;

final androidlibName = "libpolkadot_dart.so";

final dylib = Platform.isAndroid
    ? DynamicLibrary.open(androidlibName)
    : Platform.isIOS
        ? DynamicLibrary.process()
        : Platform.isMacOS
            ? DynamicLibrary.open("../macos/libpolkadot_dart.dylib")
            : Platform.isLinux
                ? DynamicLibrary.open("../linux/libpolkadot_dart.dylib")
                : Platform.isWindows
                    ? DynamicLibrary.open("../windows/libpolkadot_dart.dll")
                    : DynamicLibrary.open("../rust/target/debug/libpolkadot_dart.dylib");

// // Must Fix Utf8 because QuickJS need end with terminator '\0'
// class Utf8Fix extends Struct {
//   @Uint8()
//   int char;

//   static String fromUtf8(Pointer<Utf8Fix> ptr) {
//     final units = List<int>();
//     var len = 0;
//     while (true) {
//       final char = ptr.elementAt(len++).ref.char;
//       if (char == 0) break;
//       units.add(char);
//     }
//     return Utf8Decoder().convert(units);
//   }

//   static Pointer<Utf8Fix> toUtf8(String s) {
//     final units = Utf8Encoder().convert(s);
//     final ptr = allocate<Utf8Fix>(count: units.length + 1);
//     for (var i = 0; i < units.length; i++) {
//       ptr.elementAt(i).ref.char = units[i];
//     }
//     // Add the C string null terminator '\0'
//     ptr.elementAt(units.length).ref.char = 0;

//     return ptr;
//   }
// }
