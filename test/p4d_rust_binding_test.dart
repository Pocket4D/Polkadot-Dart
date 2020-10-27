import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/p4d_rust_binding.dart';

void main() {
  const MethodChannel channel = MethodChannel('p4d_rust_binding');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await P4dRustBinding.platformVersion, '42');
  });
}
