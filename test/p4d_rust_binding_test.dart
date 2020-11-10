import 'package:flutter_test/flutter_test.dart';
import 'package:p4d_rust_binding/p4d_rust_binding.dart';

void main() {
  test('rust binding: random_phase', () {
    var length = 12;
    var result = bip39Generate(length);
    var resultArray = result.split(" ").toList();
    expect(resultArray.length, length);
  });

  test('rust binding: random_phase_into_mini_secret', () {
    var phrase = "legal winner thank year wave sausage worth useful legal winner thank yellow";
    var password = "Substrate";
    var miniSecret = bip39ToMiniSecret(phrase, password);
    print(miniSecret);
  });
}
