import 'dart:convert';
import 'dart:typed_data';
import 'package:p4d_rust_binding/p4d_rust_binding.dart';
import 'package:convert/convert.dart';
import 'metajson.dart';

main() async {
  var phrase = "legal winner thank year wave sausage worth useful legal winner thank yellow";
  var password = "Substrate";
  var validate = bip39Validate(phrase);

  print("isValid Phrase: $validate");
  try {
    var miniSecret = bip39ToMiniSecret(phrase, password);
    print("miniSecret: $miniSecret");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let data = "abc";
    // let key = "";
    // let expected_32 = hex!("bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319");
    // let expected_64 = hex!("ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923");
    // let hash_32 = blake2b(get_ptr(data), get_ptr(key), 32);
    // let hash_64 = blake2b(get_ptr(data), get_ptr(key), 64);

    var blake2bData = plainTextToHex("abc");
    var blake2bKey = "";
    var blake2bExpected32 = "bddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319";
    var blake2bExpected64 =
        "ba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923";

    var blake2bHash32 = blake2b(blake2bData, blake2bKey, 32);
    var blake2bHash64 = blake2b(blake2bData, blake2bKey, 64);
    print("blake2bHash32 is :$blake2bHash32");
    print("blake2bHash32 equal expcted :${blake2bHash32 == blake2bExpected32}");
    print("blake2bHash64 is :$blake2bHash64");
    print("blake2bHash64 equal expcted :${blake2bHash64 == blake2bExpected64}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    //  let data = "test value";
    //  let expected = hex!("2d07364b5c231c56ce63d49430e085ea3033c750688ba532b24029124c26ca5e");
    var keccakData = "test value";
    var keccakExpected = "2d07364b5c231c56ce63d49430e085ea3033c750688ba532b24029124c26ca5e";

    var keccakHash = keccak256(keccakData);
    print("keccakHash is :$keccakHash");
    print("keccakHash equal expected:${keccakHash == keccakExpected}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let salt = "this is a salt";
    // let data = "hello world";
    // let expected = hex!("5fcbe04f05300a3ecc5c35d18ea0b78f3f6853d2ae5f3fca374f69a7d1f78b5def5c60dae1a568026c7492511e0c53521e8bb6e03a650e1263265fee92722270");
    // let hash = pbkdf2(get_ptr(data), get_ptr(salt), 2048);
    var pbkdf2Data = "hello world";
    var pbkdf2Salt = "this is a salt";
    var pbkdf2Expected =
        "5fcbe04f05300a3ecc5c35d18ea0b78f3f6853d2ae5f3fca374f69a7d1f78b5def5c60dae1a568026c7492511e0c53521e8bb6e03a650e1263265fee92722270";
    var pbkdf2Hash = await pbkdf2(pbkdf2Data, pbkdf2Salt, 2048);
    print("pbkdf2Hash is :$pbkdf2Hash");
    print("pbkdf2Hash equal expected:${pbkdf2Hash == pbkdf2Expected}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let password = "password";
    // let salt = "salt";
    // let expected = hex!("745731af4484f323968969eda289aeee005b5903ac561e64a5aca121797bf7734ef9fd58422e2e22183bcacba9ec87ba0c83b7a2e788f03ce0da06463433cda6");
    // let hash = scrypt(get_ptr(password), get_ptr(salt), 14, 8, 1);
    var scryptData = "password";
    var scryptSalt = "salt";
    var scryptExpected =
        "745731af4484f323968969eda289aeee005b5903ac561e64a5aca121797bf7734ef9fd58422e2e22183bcacba9ec87ba0c83b7a2e788f03ce0da06463433cda6";
    var scryptHash = await scrypt(scryptData, scryptSalt, 14, 8, 1);
    print("scryptHash is :$scryptHash");
    print("scryptHash equal expected:${scryptHash == scryptExpected}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let data = "hello world";
    // let expected = hex!("309ecc489c12d6eb4cc40f50c902f2b4d0ed77ee511a7c7a9bcd3ca86d4cd86f989dd35bc5ff499670da34255b45b0cfd830e81f605dcf7dc5542e93ae9cd76f");
    var sha512Data = "hello world";
    var sha512Expected =
        "309ecc489c12d6eb4cc40f50c902f2b4d0ed77ee511a7c7a9bcd3ca86d4cd86f989dd35bc5ff499670da34255b45b0cfd830e81f605dcf7dc5542e93ae9cd76f";
    var sha512Hash = sha512(sha512Data);
    print("sha512Hash is :$sha512Hash");
    print("sha512Hash equal expected:${sha512Hash == sha512Expected}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let data = "abc";
    // let expected_64 = hex!("990977adf52cbc44");
    // let expected_256 = hex!("990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b");
    // let hash_64 = twox(get_ptr(data), 1);
    // let hash_256 = twox(get_ptr(data), 4);
    var twoxData = "abc";
    var twoxExpected64 = "990977adf52cbc44";
    var twoxExpected256 = "990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b";

    var twoxHash64 = await twox(twoxData, 1);
    var twoxHash256 = await twox(twoxData, 4);
    print("twoxHash64 is :$twoxHash64");
    print("twoxHash64 equal expected:${twoxHash64 == twoxExpected64}");
    print("twoxHash256 is :$twoxHash256");
    print("twoxHash256 equal expected:${twoxHash256 == twoxExpected256}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let path = "m/0'/1'/2'/2'/1000000000'";
    // let seed = "000102030405060708090a0b0c0d0e0f";
    // let expected = hex!("8f94d394a8e8fd6b1bc2f3f49f5c47e385281d5c17e65324b0f62483e37e8793");
    var path = "m/0'/1'/2'/2'/1000000000'";
    var seed = "000102030405060708090a0b0c0d0e0f";
    var expected = "8f94d394a8e8fd6b1bc2f3f49f5c47e385281d5c17e65324b0f62483e37e8793";
    var result = bip32GetPrivateKey(seed, path);
    print("bip32 privateKey is $result");
    print("bip32 privateKey equal expected is ${result == expected}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let prv_str = "8f94d394a8e8fd6b1bc2f3f49f5c47e385281d5c17e65324b0f62483e37e8793";
    // let expected = hex!("3c24da049451555d51a7014a37337aa4e12d41e485abccfa46b47dfb2af54b7a");
    var prv = "8f94d394a8e8fd6b1bc2f3f49f5c47e385281d5c17e65324b0f62483e37e8793";
    var expected = "3c24da049451555d51a7014a37337aa4e12d41e485abccfa46b47dfb2af54b7a";
    var result = ed25519GetPubFromPrivate(prv);
    print("ed25519 pub is $result");
    print("ed25519 pub equal expected is ${result == expected}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let prv_str = "8f94d394a8e8fd6b1bc2f3f49f5c47e385281d5c17e65324b0f62483e37e8793";
    // let expected = hex!("0215197801d5ba7001d143183d04bf4e675be6c24b5101fc89de1659d50dbbaa24");
    var prv = "8f94d394a8e8fd6b1bc2f3f49f5c47e385281d5c17e65324b0f62483e37e8793";
    var expected = "0215197801d5ba7001d143183d04bf4e675be6c24b5101fc89de1659d50dbbaa24";
    var result = secp256k1GetPubFromPrivate(prv);
    print("secp256k1 pub is $result");
    print("secp256k1 pub equal expected is ${result == expected}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let seed = "9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60";
    // let expected = hex!("44a996beb1eef7bdcab976ab6d2ca26104834164ecf28fb375600576fcc6eb0f");
    var seed = "9d61b19deffd5a60ba844af492ec2cc44449c5697b326919703bac031cae7f60";
    var expected = "44a996beb1eef7bdcab976ab6d2ca26104834164ecf28fb375600576fcc6eb0f";
    var result = sr25519GetPubFromSeed(seed);
    var result2 = SR25519.getPubFromSeed(seed);
    print("sr25519 pub is $result");
    print("sr25519 pub equal expected is ${result == expected}  ");
    print("sr25519 pub2 equal expected is ${result2 == expected}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let seed = b"12345678901234567890123456789012";
    // let seed_string: String = seed.to_vec().to_hex();
    // let expected = hex!("2f8c6129d816cf51c374bc7f08c3e63ed156cf78aefb4a6550d97b87997977ee");
    // let keypair_ptr = ed25519_keypair_from_seed(get_ptr(seed_string.as_str()));
    // let keypair = get_u8vec_from_ptr(keypair_ptr);
    // let public = &keypair[ed25519_dalek::SECRET_KEY_LENGTH..ed25519_dalek::KEYPAIR_LENGTH];
    var seed = "12345678901234567890123456789012";
    var expected = "2f8c6129d816cf51c374bc7f08c3e63ed156cf78aefb4a6550d97b87997977ee";
    var seedHex = plainTextToHex(seed);
    var kp = ed25519KeypairFromSeed(seedHex);
    var prv = kp.substring(0, kp.length - expected.length);
    var pub = kp.substring(kp.length - expected.length, kp.length);
    var expected2 = ed25519GetPubFromPrivate(prv);
    var kp2 = ED25519.fromSeed(seedHex);
    var prv2 = kp2.private;
    var pub2 = kp2.public;
    var expected3 = ED25519.getPubFromPrivate(prv2);

    print("ed25519 pub is $pub");
    print("ed25519 pub equal expected is ${pub == expected}");
    print("ed25519 pub equal expected2 is ${pub == expected2}");
    print("ed25519 pub equal expected3 is ${pub2 == expected3}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    var seed = bip39ToSeed(bip39Generate(12), "");
    var randompub = "2f8c6129d816cf51c374bc7f08c3e63ed156cf78aefb4a6550d97b87997977ee"; // some pub
    var message = "this is a message";
    var kp = ed25519KeypairFromSeed(seed);
    var prv = kp.substring(0, kp.length - randompub.length);
    var pub = kp.substring(kp.length - randompub.length, kp.length);
    var signature = ed25519Sign(pub, prv, plainTextToHex(message));
    var verified = ed25519Verify(signature, plainTextToHex(message), pub);

    var kp2 = ED25519.fromSeed(seed);
    var signature2 = kp2.sign(message);
    var verified2 = ED25519.verify(signature, message, pub);

    print("ed25519 signature is $signature");
    print("ed25519 signature match is: ${signature.length == kp.length}");
    print("ed25519 signature verified: $verified");
    print("ed25519 signature2 is $signature2");
    print("ed25519 signature2 match is: ${signature2.length == kp2.keyPair.length}");
    print("ed25519 signature2 verified: $verified2");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    var expected =
        "90588f3f512496f2dd40571d162e8182860081c74e2085316e7c4396918f07da412ee029978e4dd714057fe973bd9e7d645148bf7b66680d67c93227cde95202"; // some pub
    var message = "this is a message";
    var pub = "2f8c6129d816cf51c374bc7f08c3e63ed156cf78aefb4a6550d97b87997977ee";
    var verified = ed25519Verify(expected, plainTextToHex(message), pub);
    var verified2 = ED25519.verify(expected, message, pub);
    print("ed25519 signature is $expected");
    print("ed25519 signature verified: $verified");
    print("ed25519 signature verified2: $verified2");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    var expected = "46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a";
    var seed = "fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e";
    var keypair = sr25519KeypairFromSeed(seed);
    var pub = keypair.substring(seed.length * 2, keypair.length);
    var keypair2 = SR25519.fromSeed(seed);
    var pub2 = keypair2.public;
    print("sr25519 pub is $pub");
    print("sr25519 equal expected: ${pub == expected}");
    print("sr25519 pub2 is $pub2");
    print("sr25519 equal expected2: ${pub2 == expected}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    var seed = bip39ToSeed(bip39Generate(12), "");
    var keypair = sr25519KeypairFromSeed(seed);
    var prv = keypair.substring(0, 128);
    var pub = keypair.substring(128, keypair.length);
    var message = plainTextToHex("this is a message");
    var signature = sr25519Sign(pub, prv, message);
    var verified = sr25519Verify(signature, message, pub);

    var keypair2 = SR25519.fromSeed(seed);

    var message2 = "this is a message";
    var signature2 = keypair2.sign(message2);
    var verified2 = SR25519.verify(signature2, message2, keypair2.public);

    print("sr25519 signature is $signature");
    print("sr25519 signature length is ${signature.length}");
    print("sr25519 signature verified: $verified");

    print("sr25519 signature2 is $signature2");
    print("sr25519 signature2 length is ${signature2.length}");
    print("sr25519 signature2 verified2: $verified2");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    var pub = "d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d";
    var message = plainTextToHex(
        "I hereby verify that I control 5GrwvaEF5zXb26Fz9rcQpDWS57CtERHpNehXCPcNoHGKutQY");
    var signature =
        "1037eb7e51613d0dcf5930ae518819c87d655056605764840d9280984e1b7063c4566b55bf292fcab07b369d01095879b50517beca4d26e6a65866e25fec0d83";
    var verified = sr25519Verify(signature, message, pub);
    var verified2 = SR25519.verify(signature, message, pub);
    print("sr25519 signature is $signature");
    print("sr25519 signature length is ${signature.length}");
    print("sr25519 signature verified: $verified");
    print("sr25519 signature verified2: $verified2");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    // let cc = hex!("0c666f6f00000000000000000000000000000000000000000000000000000000"); // foo
    // let seed = hex!("fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e");
    // let expected = hex!("40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a");
    var cc = "0c666f6f00000000000000000000000000000000000000000000000000000000";
    var seed = "fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e";
    var expected = "40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a";
    var keypair = sr25519KeypairFromSeed(seed);
    var derivedPair = sr25519DeriveKeypairSoft(keypair, cc);
    var pub = derivedPair.substring(128, keypair.length);

    final keypair2 = SR25519.fromSeed(seed);
    final derivedPair2 = SR25519.deriveKeypairSoft(keypair2.keyPair, cc);
    final pub2 = derivedPair2.public;

    print("sr25519 derived_soft keypair is $keypair");
    print("sr25519 derived_soft pubkey is $pub");
    print("sr25519 derived_soft pubkey equals expected: ${expected == pub}");

    print("sr25519 derived_soft keypair2 is ${keypair2.keyPair}");
    print("sr25519 derived_soft pubkey2 is $pub2");
    print("sr25519 derived_soft pubkey2 equals expected: ${expected == pub2}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    var cc = "0c666f6f00000000000000000000000000000000000000000000000000000000";
    var expected = "40b9675df90efa6069ff623b0fdfcf706cd47ca7452a5056c7ad58194d23440a";
    var pub = "46ebddef8cd9bb167dc30878d7113b7e168e6f0646beffd77d69d39bad76b47a";
    var derivedPublic = sr25519DerivePublicSoft(pub, cc);
    var derivedPublic2 = SR25519.derivePublicSoft(pub, cc);
    print("sr25519 derived_soft pubkey is $derivedPublic");
    print("sr25519 derived_soft pubkey equals expected: ${expected == derivedPublic}");
    print("sr25519 derived_soft pubkey2 is $derivedPublic2");
    print("sr25519 derived_soft pubkey equals expected: ${expected == derivedPublic2}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    var cc = "14416c6963650000000000000000000000000000000000000000000000000000";
    var seed = "fac7959dbfe72f052e5a0c3c8d6530f202b02fd8f9f5ca3580ec8deb7797479e";
    var expected = "d43593c715fdd31c61141abd04a99fd6822c8558854ccde39a5684e7a56da27d";
    var keypair = sr25519KeypairFromSeed(seed);
    var derivedPair = sr25519DeriveKeypairHard(keypair, cc);
    var pub = derivedPair.substring(128, keypair.length);

    var keypair2 = SR25519.fromSeed(seed);
    var derivedPair2 = SR25519.deriveKeypairHard(keypair2.keyPair, cc);
    var pub2 = derivedPair2.public;

    print("sr25519 derived_hard keypair is $keypair");
    print("sr25519 derived_hard pubkey is $pub");
    print("sr25519 derived_hard pubkey equals expected: ${expected == pub}");
    print("sr25519 derived_hard keypair2 is ${keypair2.keyPair}");
    print("sr25519 derived_hard pubkey2 is $pub2");
    print("sr25519 derived_hard pubkey2 equals expected: ${expected == pub2}");
    print("\n");
  } catch (e) {
    print(e);
  }

  try {
    var a = Uint8List.fromList([1, 2, 3]);
    var b = Uint8List.fromList([4, 5, 6]);
    var some2 = u8aConcat([a, b]);
    print(some2);
    print(u8aSorted([a, b]));

    var c = "hello";
    var space = " ";
    var d = "world";
    var some3 = u8aConcat([c, space, d]);
    var sooor = u8aSorted([stringToU8a(c), stringToU8a(space), stringToU8a(d)]);

    print(some3);
    print(u8aConcat(sooor));

    var e = "hello world";
    var some4 = stringToU8a(e);
    print(some4);

    print(u8aEq(some3, some4));

    var f = '0x1234';
    var some5 = stringToU8a(f, 'hex');
    print(some5);

    print(bytesToHex(u8aFixLength(some5, bitLength: 16), include0x: true));

    var g = Uint8List.fromList([0x68, 0x65, 0x6c, 0xf]);
    print(u8aToHex(g));
    print(u8aToBn(g));
    print(u8aToBuffer(g));

    var h = Uint8List.fromList([0x68, 0x65, 0x6c, 0x6c, 0x6f]);
    print(u8aToString(h));
  } catch (e) {
    throw ("u8a Error :$e");
  }

  try {
    print(zeroPad(5));
    print(formatDate(DateTime.now()));
    print(formatDecimal("-test"));
    var start = 12345678;
    var now = DateTime.fromMillisecondsSinceEpoch(start);

    var eee = formatElapsed(
        now, BigInt.from(DateTime.fromMillisecondsSinceEpoch(start + 9700).millisecondsSinceEpoch));

    var fff = formatElapsed(now, BigInt.from(start + 42700));
    var ggg = formatElapsed(now, BigInt.from(start + (5.3 * 60000)));
    var hhh = formatElapsed(now, BigInt.from(start + (42 * 60 * 60000)));
    var jjj = formatElapsed();

    print(eee);
    print(fff);
    print(ggg);
    print(hhh);
    print(jjj);

    var testVal = BigInt.from(123456789000);
    var option1 = BalanceFormatterOptions(decimals: 15, withSi: true);
    var option2 = BalanceFormatterOptions(decimals: 0, withSi: true);
    var option3 = BalanceFormatterOptions(decimals: 36, withSi: true);
    var option4 = BalanceFormatterOptions(withSi: true);
    var option5 = BalanceFormatterOptions(withSi: true, withUnit: 'BAR');
    var option6 = BalanceFormatterOptions(
      withSi: true,
    );
    var option7 = BalanceFormatterOptions(
      forceUnit: '-',
    );
    var option8 = BalanceFormatterOptions(
      withUnit: '🔥',
    );

    BalanceFormatter();
    print(BalanceFormatter.instance.formatBalance(testVal, option1)); // 123.4567 µUnit
    print(BalanceFormatter.instance.formatBalance(123456, option2)); // 123.4560 kUnit
    print(BalanceFormatter.instance.formatBalance(testVal, option3)); // 0.1234 yUnit
    print(BalanceFormatter.instance.formatBalance(testVal, option4, 6)); // 123.4567 kUnit
    print(BalanceFormatter.instance.formatBalance(testVal, option5, 6)); // 123.4567 kBAR
    print(BalanceFormatter.instance
        .formatBalance(BigInt.from(-123456789000), option6, 15)); // -123.4567 µUnit
    print(BalanceFormatter.instance.formatBalance(testVal, option7, 7)); // 12,345.6789 Unit
    print(BalanceFormatter.instance.formatBalance(testVal, option8, 15)); // 123.4567 µ🔥
    BalanceFormatter.instance.setDefaults(Defaults(decimals: 0, unit: 'TEST'));
    print(BalanceFormatter.instance.getOptions()); // [{power: 0, text: TEST, value: -},...]
  } catch (e) {
    throw "format Error: $e";
  }

  try {
    var jsonData = MetaDataJson.fromMap(metaJson);
    var systemModule =
        jsonData.metadata.version.modules.firstWhere((element) => element.name == 'System');
    if (systemModule.storage.prefix == "System") {
      systemModule.storage.items.forEach((e) => print("${e.toMap()} \n"));
    }
  } catch (e) {
    throw e;
  }

  try {
    const test = '1234abcd';
    print("\n");
    print("----- isHex");
    print(isHex('0x')); // true
    print(isHex("0x$test")); // true
    print(isHex("0x${test}0")); // false
    print(isHex("0x${test.toUpperCase()}")); // true
    print(isHex(test)); // false
    print(isHex(false)); // false
    print(isHex('0x1234', 16)); // true
    print(isHex('0x1234', 8)); // false
    print(isHex('1234')); // false

    const jsonObject = {
      "Test": "1234",
      "NestedTest": {"Test": "5678"}
    };
    print("\n");
    print("----- isJsonObject");
    print(isJsonObject("{}")); // true
    print(isJsonObject("${jsonEncode(jsonObject)}")); // true
    print(isJsonObject(123)); // false
    print(isJsonObject(null)); // false
    print(isJsonObject("asdfasdf")); // false
    print(isJsonObject("{'abc','def'}")); // false
    print("\n");
    print("----- testchain");
    var validTestModeChainSpecsWithDev = ['Development'];
    var validTestModeChainSpecsWithLoc = ['Local Testnet'];

    validTestModeChainSpecsWithDev.addAll(validTestModeChainSpecsWithLoc);
    validTestModeChainSpecsWithDev.forEach((element) {
      print(isTestChain(element));
    });

    const invalidTestModeChainSpecs = [
      'dev',
      'local',
      'development',
      'PoC-1 Testnet',
      'Staging Testnet',
      'future PoC-2 Testnet',
      'a pocadot?',
      null
    ];

    invalidTestModeChainSpecs.forEach((s) {
      print(isTestChain(s));
    });
    print("\n");
    print("----- utf8");

    print(isUtf8('Hello\tWorld!\n\rTesting')); // true
    print(isUtf8(Uint8List.fromList([0x31, 0x32, 0x20, 10]))); // true
    print(isUtf8('')); // true
    print(isUtf8([])); // true
    print(isUtf8('Приветствую, ми')); // true
    print(isUtf8('你好')); // true
    print(isUtf8('0x7f07b1f87709608bee603bbc79a0dfc29cd315c1351a83aa31adf7458d7d3003')); // false
    print("\n");
    print("-----hexAddPrefix");
    print(hexAddPrefix('0x0123')); //0x0123
    print(hexAddPrefix('0123')); //0x0123
    print(hexAddPrefix('123')); //0x0123
    print(hexAddPrefix(null)); //'0x'
    print("\n");
    print("-----hexFixLength");
    print(hexFixLength('0x12345678')); //0x12345678
    print(hexFixLength('0x1234567')); //0x01234567
    print(hexFixLength('0x12345678', 32)); //0x12345678
    print(hexFixLength('0x12345678', 16)); //0x5678 -->
    print(hexFixLength('0x1234', 32)); //0x1234
    print(hexFixLength('0x1234', 32, true)); // 0x00001234 -->
    print("\n");
    print("-----hexHasPrefix");
    print(hexHasPrefix('0x123')); //true
    print(hexHasPrefix('123')); //false
    print(hexHasPrefix(null)); //false;

    print("\n");
    print("----- hexStripPrefix");

    print(hexStripPrefix(null)); //''
    print(hexStripPrefix("0x1223")); // 1223
    print(hexStripPrefix('abcd1223')); //abcd1223
    // print(hexStripPrefix('0x0x01ab')); //throw

    print("\n");
    print("----- hexToBn");
    print(hexStripPrefix('0x'));
    print(hexToBn(0x81).toRadixString(16)); //81
    print(hexToBn(null).toInt()); //0;
    print(hexToBn('0x').toInt()); //0;
    print(hexToBn('0x0100').toInt()); // 256
    print(hexToBn('0x4500000000000000', endian: Endian.little).toInt()); //69
    print(hexToBn('0x2efb', endian: Endian.little, isNegative: true).toInt()); // -1234
    print(hexToBn('0xfb2e', endian: Endian.big, isNegative: true).toInt()); // -1234
    print(hexToBn('0x00009c584c491ff2ffffffffffffffff', endian: Endian.little, isNegative: true)
        .toString()); //-1000000000000000000
    print(hexToBn('0x0000000000000100', endian: Endian.big).toInt()); // 256
    print(hexToBn('0x0001000000000000', endian: Endian.little).toInt()); // 256
    print(
        hexToBn('0x0001000000000000', endian: Endian.big) == hexToBn('0x0001000000000000')); // true

    print("\n");
    print("----- hexToNumber");
    print(hexToNumber(0x1234) == 0x1234); // true
    print(hexToNumber(null)); // null

    print("\n");
    print("----- hexToString");
    print(hexToString('0x68656c6c6f')); // hello

    print("\n");
    print("----- hexToU8a");
    print(u8aEq(hexToU8a('0x80000a'), Uint8List.fromList([128, 0, 10]))); // true
    print(u8aEq(hexToU8a('0x80000a', 32), Uint8List.fromList([0, 128, 0, 10]))); // true

    print("\n");
    print("----- bnToHex");
    print(bnToHex(null)); // 0x00
    print(bnToHex(BigInt.from(128))); // 0x80 -- >
    print(bnToHex(BigInt.from(128), bitLength: 16)); // 0x0080 -- >
    print(bnToHex(BigInt.from(128), bitLength: 16, endian: Endian.little)); // 0x8000
    print(bnToHex(BigInt.from(-1234), isNegative: true)); // 0xfb2e
    print(bnToHex(BigInt.from(-1234), bitLength: 32, isNegative: true)); // 0xfffffb2e

    print("\n");
    print("----- bnToU8a");
    print(bnToU8a(null, bitLength: 32, isNegative: false)); // [0,0,0,0]
    print(bnToU8a(BigInt.from(0x123456), bitLength: -1, endian: Endian.big)); // [0x12, 0x34, 0x56]
    print(bnToU8a(BigInt.from(0x123456),
        bitLength: 32, endian: Endian.big)); // [0x00, 0x12, 0x34, 0x56]
    print(bnToU8a(BigInt.from(0x123456),
        bitLength: 32, endian: Endian.little)); // [0x56, 0x34, 0x12, 0x00]
    print(bnToU8a(BigInt.from(-1234), endian: Endian.little, isNegative: true)); // [46,251]
    print(bnToU8a(BigInt.from(-1234), endian: Endian.big, isNegative: true)); // [251,46]
    print(bnToU8a(BigInt.from(-1234),
        bitLength: 32, isNegative: true)); // [46, 251, 255, 255] -- different from [46,251,255,255]

    print("\n");
    print('----- bnMax');
    print(bnMax([BigInt.from(1), BigInt.from(2), BigInt.from(3)]).toString()); // 3

    print("\n");
    print('----- bnMin');
    print(bnMin([BigInt.from(1), BigInt.from(2), BigInt.from(3)]).toString()); // 1

    print("\n");
    print('----- bnSqrt');
    print(bnSqrt(BigInt.from(16))); // 4

    print("\n");
    print("----- compactToU8a");
    print(compactToU8a(18)); // Uint8List.fromList([18 << 2])
    print(compactToU8a(BigInt.from(
        63))); // new Uint8Array([0b11111100]) -> print(bnToU8a(BigInt.tryParse('11111100', radix: 2)));
    print(compactToU8a(
        511)); // new Uint8Array([0b11111101, 0b00000111]) -> print(bnToU8a(BigInt.tryParse('0000011111111101', radix: 2), endian: Endian.little));
    print(compactToU8a(111)); // new Uint8Array([0xbd, 0x01])
    print(Uint8List.fromList([0xbd, 0x01]));
    print(compactToU8a(0x1fff)); // new Uint8Array([254, 255, 3, 0])
    print(Uint8List.fromList([254, 255, 3, 0]));
    print(compactToU8a(0xfffffff9)); // new Uint8Array([3 + ((4 - 4) << 2), 249, 255, 255, 255])
    print(Uint8List.fromList([3 + ((4 - 4) << 2), 249, 255, 255, 255]));
    print(compactToU8a(BigInt.parse('00005af3107a4000',
        radix: 16))); // new Uint8Array([3 + ((6 - 4) << 2), 0x00, 0x40, 0x7a, 0x10, 0xf3, 0x5a])

    List<Map<String, dynamic>> testCases = [
      {"expected": '00', "value": BigInt.parse('0')},
      {"expected": 'fc', "value": BigInt.parse('63')},
      {"expected": '01 01', "value": BigInt.parse('64')},
      {"expected": 'fd ff', "value": BigInt.parse('16383')},
      {"expected": '02 00 01 00', "value": BigInt.parse('16384')},
      {"expected": 'fe ff ff ff', "value": BigInt.parse('1073741823')},
      {"expected": '03 00 00 00 40', "value": BigInt.parse('1073741824')},
      {
        "expected": '03 ff ff ff ff',
        "value": BigInt.parse("${1}${'0' * (32)}", radix: 2) - BigInt.one
      },
      {"expected": '07 00 00 00 00 01', "value": BigInt.parse("1${'0' * (32)}", radix: 2)},
      {"expected": '0b 00 00 00 00 00 01', "value": BigInt.parse("1${'0' * (40)}", radix: 2)},
      {"expected": '0f 00 00 00 00 00 00 01', "value": BigInt.parse("1${'0' * (48)}", radix: 2)},
      {
        "expected": '0f ff ff ff ff ff ff ff',
        "value": BigInt.parse("1${'0' * (56)}", radix: 2) - BigInt.one
      },
      {"expected": '13 00 00 00 00 00 00 00 01', "value": BigInt.parse("1${'0' * (56)}", radix: 2)},
      {
        "expected": '13 ff ff ff ff ff ff ff ff',
        "value": BigInt.parse("1${'0' * (64)}", radix: 2) - BigInt.one
      }
    ];

    testCases.forEach((t) {
      var map = Map<String, dynamic>.from(t);
      var expected = map["expected"] as String;
      var u8List = Uint8List.fromList(expected.split(" ").map((element) {
        return int.parse(element, radix: 16);
      }).toList());
      print("expected $expected: ${u8aEq(u8List, compactToU8a(map["value"] as BigInt))}");
    });

    print("\n");
    print('----- compactAddLength');
    print(compactAddLength(Uint8List.fromList([12, 13]))); // [8, 12, 13]

    print("\n");
    print('----- compactStripLength');
    print(compactStripLength(Uint8List.fromList([2 << 2, 12, 13]))); // [3, [12, 13]]

    print("\n");
    print("------ stringCamelCase");
    print(stringCamelCase("ABC")); // abc

    print("\n");
    print("------ stringLowerFirst");
    print(stringLowerFirst("ABC")); // aBC

    print("\n");
    print("----- stringShorten");
    print(stringShorten('0123456789', prefixLength: 4)); // 0123456789
    print(stringShorten('0123456789', prefixLength: 3)); // 012…789
    print(stringShorten(
        '0x7f07b1f87709608bee603bbc79a0dfc29cd315c1351a83aa31adf7458d7d3003')); // 0x7f07…7d3003

    print("\n");
    print("----- stringUpperFirst");
    print(stringUpperFirst("abc")); // Abc

    print("\n");
    print("----- extractTime");
    const milliseconds = 1e9 + 123;
    print(extractTime(milliseconds)
        .toJson()); // {"days":11,"hours":13,"milliseconds":123,"minutes":46,"seconds":40}

    print("\n");
    print("----- scryptEncode");
    var scryptEncoded = await scryptEncode("123123123");
    print(scryptEncoded); //{N:32768,p:1,r:8,password:[...],salt:[...]}
    var salt = scryptEncoded["salt"] as Uint8List;
    var sU8a = scryptToU8a(salt, ScryptParams.fromMap(scryptEncoded).toMap());
    var mU8a = scryptFromU8a(sU8a);
    print(mU8a); //{N:32768,p:1,r:8,salt:[...]}

    print("\n");
    print("----- xxhash64AsValue");
    print((xxhash64AsValue('abcd', 0xabcd)).toRadixString(16)); // e29f70f8b8c96df7
    print((xxhash64AsValue(Uint8List.fromList([0x61, 0x62, 0x63, 0x64]), 0xabcd))
        .toRadixString(16)); // e29f70f8b8c96df7

    print("\n");
    print("----- xxhashAsU8a");
    print(xxhashAsU8a("abc")); // [153, 9, 119, 173, 245, 44, 188, 68]
    print(await xxhashAsU8aAsync("abc")); // [153, 9, 119, 173, 245, 44, 188, 68]
    print(hexToU8a('0x990977adf52cbc44')); // [153, 9, 119, 173, 245, 44, 188, 68]
    print(xxhashAsU8a('abc',
        bitLength:
            128)); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190]
    print(await xxhashAsU8aAsync("abc",
        bitLength:
            128)); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190]
    print(hexToU8a(
        '0x990977adf52cbc440889329981caa9be')); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190]
    print(xxhashAsU8a('abc',
        bitLength:
            256)); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190, 247, 218, 87, 112, 178, 184, 160, 83, 3, 183, 93, 149, 54, 13, 214, 43]
    print(await xxhashAsU8aAsync("abc",
        bitLength:
            256)); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190, 247, 218, 87, 112, 178, 184, 160, 83, 3, 183, 93, 149, 54, 13, 214, 43]
    print(hexToU8a(
        '0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b')); // [153, 9, 119, 173, 245, 44, 188, 68, 8, 137, 50, 153, 129, 202, 169, 190, 247, 218, 87, 112, 178, 184, 160, 83, 3, 183, 93, 149, 54, 13, 214, 43]

    print("\n");
    print("----- xxhashAsHex");
    print(xxhashAsHex("abc")); // 0x990977adf52cbc44
    print(await xxhashAsHexAsync("abc")); // 0x990977adf52cbc44
    print(xxhashAsHex("abc", bitLength: 128)); // 0x990977adf52cbc440889329981caa9be
    print(await xxhashAsHexAsync("abc",
        bitLength: 128)); // 0x990977ad0x990977adf52cbc440889329981caa9bef52cbc44
    print(xxhashAsHex("abc",
        bitLength: 256)); // 0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b
    print(await xxhashAsHexAsync("abc",
        bitLength: 256)); // 0x990977adf52cbc440889329981caa9bef7da5770b2b8a05303b75d95360dd62b
  } catch (e) {
    throw e;
  }

  try {
    print("\n");
    print("----- naclKeypairFromSeed");
    var testU8a = stringToU8a('12345678901234567890123456789012');
    print(u8aEq(
        naclKeypairFromSeed(testU8a).publicKey,
        Uint8List.fromList([
          0x2f,
          0x8c,
          0x61,
          0x29,
          0xd8,
          0x16,
          0xcf,
          0x51,
          0xc3,
          0x74,
          0xbc,
          0x7f,
          0x08,
          0xc3,
          0xe6,
          0x3e,
          0xd1,
          0x56,
          0xcf,
          0x78,
          0xae,
          0xfb,
          0x4a,
          0x65,
          0x50,
          0xd9,
          0x7b,
          0x87,
          0x99,
          0x79,
          0x77,
          0xee
        ])));
    print(u8aEq(
        naclKeypairFromSeed(testU8a).secretKey,
        Uint8List.fromList([
          49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50,
          51, 52, 53, 54, 55, 56, 57, 48, 49, 50,
          // public part
          0x2f, 0x8c, 0x61, 0x29, 0xd8, 0x16, 0xcf, 0x51,
          0xc3, 0x74, 0xbc, 0x7f, 0x08, 0xc3, 0xe6, 0x3e,
          0xd1, 0x56, 0xcf, 0x78, 0xae, 0xfb, 0x4a, 0x65,
          0x50, 0xd9, 0x7b, 0x87, 0x99, 0x79, 0x77, 0xee
        ])));
    print(u8aEq(
        naclKeypairFromSeed(testU8a, useNative: false).publicKey,
        Uint8List.fromList([
          0x2f,
          0x8c,
          0x61,
          0x29,
          0xd8,
          0x16,
          0xcf,
          0x51,
          0xc3,
          0x74,
          0xbc,
          0x7f,
          0x08,
          0xc3,
          0xe6,
          0x3e,
          0xd1,
          0x56,
          0xcf,
          0x78,
          0xae,
          0xfb,
          0x4a,
          0x65,
          0x50,
          0xd9,
          0x7b,
          0x87,
          0x99,
          0x79,
          0x77,
          0xee
        ])));
    print(u8aEq(
        naclKeypairFromSeed(testU8a, useNative: false).secretKey,
        Uint8List.fromList([
          49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 48, 49, 50,
          51, 52, 53, 54, 55, 56, 57, 48, 49, 50,
          // public part
          0x2f, 0x8c, 0x61, 0x29, 0xd8, 0x16, 0xcf, 0x51,
          0xc3, 0x74, 0xbc, 0x7f, 0x08, 0xc3, 0xe6, 0x3e,
          0xd1, 0x56, 0xcf, 0x78, 0xae, 0xfb, 0x4a, 0x65,
          0x50, 0xd9, 0x7b, 0x87, 0x99, 0x79, 0x77, 0xee
        ])));
    print("\n");
    print("----- naclKeypairFromRandom");
    final randomNaclKeypair = naclKeypairFromRandom();
    print(randomNaclKeypair.publicKey.length == 32);
    print(randomNaclKeypair.secretKey.length == 64);

    print("\n");
    print("----- naclKeypairFromSecret");
    final testNaclSecretKey = Uint8List.fromList([
      18,
      52,
      86,
      120,
      144,
      18,
      52,
      86,
      120,
      144,
      18,
      52,
      86,
      120,
      144,
      18,
      18,
      52,
      86,
      120,
      144,
      18,
      52,
      86,
      120,
      144,
      18,
      52,
      86,
      120,
      144,
      18,
      180,
      114,
      93,
      155,
      165,
      255,
      217,
      82,
      16,
      250,
      209,
      11,
      193,
      10,
      88,
      218,
      190,
      190,
      41,
      193,
      236,
      252,
      1,
      152,
      216,
      214,
      0,
      41,
      45,
      138,
      13,
      53
    ]);
    var expectedNaclKeypairFromSecret = Uint8List.fromList([
      180,
      114,
      93,
      155,
      165,
      255,
      217,
      82,
      16,
      250,
      209,
      11,
      193,
      10,
      88,
      218,
      190,
      190,
      41,
      193,
      236,
      252,
      1,
      152,
      216,
      214,
      0,
      41,
      45,
      138,
      13,
      53
    ]);
    print(u8aEq(naclKeypairFromSecret(testNaclSecretKey).secretKey, testNaclSecretKey));
    print(u8aEq(naclKeypairFromSecret(testNaclSecretKey).publicKey, expectedNaclKeypairFromSecret));

    print("\n");
    print("----- naclKeypairFromString");
    var kpFrmStr = naclKeypairFromString('test');
    var prvFromStr = Uint8List.fromList([
      146,
      139,
      32,
      54,
      105,
      67,
      226,
      175,
      209,
      30,
      188,
      14,
      174,
      46,
      83,
      169,
      59,
      241,
      119,
      164,
      252,
      243,
      91,
      204,
      100,
      213,
      3,
      112,
      78,
      101,
      226,
      2,
      188,
      108,
      179,
      142,
      36,
      142,
      76,
      87,
      77,
      193,
      147,
      139,
      254,
      110,
      196,
      217,
      117,
      233,
      167,
      165,
      250,
      150,
      247,
      237,
      198,
      68,
      129,
      4,
      211,
      209,
      136,
      48
    ]);
    var pubFromStr = Uint8List.fromList([
      188,
      108,
      179,
      142,
      36,
      142,
      76,
      87,
      77,
      193,
      147,
      139,
      254,
      110,
      196,
      217,
      117,
      233,
      167,
      165,
      250,
      150,
      247,
      237,
      198,
      68,
      129,
      4,
      211,
      209,
      136,
      48
    ]);
    print(u8aEq(kpFrmStr.secretKey, prvFromStr));
    print(u8aEq(kpFrmStr.secretKey, prvFromStr));

    print("\n");
    print("----- naclEncrypt");
    var testNaclSecret = Uint8List(32);
    var testNaclMessage = Uint8List.fromList([1, 2, 3, 4, 5, 4, 3, 2, 1]);
    var testNaclNonce = Uint8List(24);
    var testNaclEncrypted = naclEncrypt(testNaclMessage, testNaclSecret, testNaclNonce);
    print(testNaclEncrypted.encrypted);
    print(testNaclEncrypted.nonce);

    print("\n");
    print("----- naclDecrypt");
    var testMaclDecrypted =
        naclDecrypt(testNaclEncrypted.encrypted, testNaclEncrypted.nonce, testNaclSecret);
    print(testMaclDecrypted);

    print("\n");
    print("----- naclDeriveHard");

    print("\n");
    print("----- naclSeal");
    final naclSealmessage = Uint8List.fromList([1, 2, 3, 4, 5, 4, 3, 2, 1]);
    final naclSealsender = naclKeypairFromString('sender');
    final naclSealreceiver = naclKeypairFromString('receiver');
    final naclSealsenderBox = naclBoxKeypairFromSecret(naclSealsender.secretKey);
    final naclSealreceiverBox = naclBoxKeypairFromSecret(naclSealreceiver.secretKey);
    final naclSealsenderBoxSecret = naclSealsenderBox.secretKey;
    final naclSealreceiverBoxPublic = naclSealreceiverBox.publicKey;

    var naclSealed = naclSeal(
        naclSealmessage, naclSealsenderBoxSecret, naclSealreceiverBoxPublic, Uint8List(24));

    print(naclSealed.toMap());

    print("\n");
    print("----- naclOpen");
    var naclOpened = naclOpen(naclSealed.sealed, naclSealed.nonce, naclSealsenderBox.publicKey,
        naclSealreceiverBox.secretKey);
    print(naclOpened);

    print("\n");
    print("----- blake2AsU8a");
    var bbb = blake2AsU8a("abc", bitLength: 512);
    print(u8aEq(
        bbb,
        hexToU8a(
            '0xba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923')));

    print("\n");
    print("---- blake2AsHex");

    print(blake2AsHex('abc')); // 0xbddd813c634239723171ef3fee98579b94964e3bb1cb3e427262c8c068d52319
    print(blake2AsHex('abc', bitLength: 64)); // 0xd8bb14d833d59559
    print(blake2AsHex('abc', bitLength: 128)); // 0xcf4ab791c62b8d2b2109c90275287816
    print(blake2AsHex('abc',
        bitLength:
            512)); // 0xba80a53f981c4d0d6a2797b69f12f6e94c212f14685ac4b74b12bb6fdbffa2d17d87c5392aab792dc252d5de4533cc9518d38aa8dbf1925ab92386edd4009923
    print(blake2AsHex(
        hexToU8a(
            '0x454545454545454545454545454545454545454545454545454545454545454501000000000000002481853da20b9f4322f34650fea5f240dcbfb266d02db94bfa0153c31f4a29dbdbf025dd4a69a6f4ee6e1577b251b655097e298b692cb34c18d3182cac3de0dc00000000'),
        bitLength: 256)); // 0x1025e5db74fdaf4d2818822dccf0e1604ae9ccc62f26cecfde23448ff0248abf

    print(blake2AsHex(
        textDecoder(hexToU8a(
            '0x454545454545454545454545454545454545454545454545454545454545454501000000000000002481853da20b9f4322f34650fea5f240dcbfb266d02db94bfa0153c31f4a29dbdbf025dd4a69a6f4ee6e1577b251b655097e298b692cb34c18d3182cac3de0dc00000000')),
        bitLength: 256));
  } catch (e) {
    throw e;
  }

  try {
    print("\n");
    print("----- keyExtractPath");
    var keyExtractPathResult = keyExtractPath('/1');
    print(keyExtractPathResult.parts); // ["/1"]
    print(keyExtractPathResult.path.length); // 1
    print(keyExtractPathResult.path[0].isHard); // false
    print(keyExtractPathResult.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    var keyExtractPathResult2 = keyExtractPath('//1');
    print(keyExtractPathResult2.parts); // ["//1"]
    print(keyExtractPathResult2.path.length); // 1
    print(keyExtractPathResult2.path[0].isHard); // true
    print(keyExtractPathResult2.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    var keyExtractPathResult3 = keyExtractPath('//1/2');
    print(keyExtractPathResult3.parts); // ["//1","/2"]
    print(keyExtractPathResult3.path.length); // 2
    print(keyExtractPathResult3.path[0].isHard); // true
    print(keyExtractPathResult3.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    print(keyExtractPathResult3.path[1].isHard); // false
    print(keyExtractPathResult3.path[1]
        .chainCode); // Uint8List.fromList([2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    print("\n");
    print("----- keyExtractSuri");
    var keyExtractSuriTest = keyExtractSuri('hello world');
    print(keyExtractSuriTest.phrase); // 'hello world'
    print(keyExtractSuriTest.path.length); // 0

    var keyExtractSuriTest2 = keyExtractSuri('hello world/1');
    print(keyExtractSuriTest2.password); // ''
    print(keyExtractSuriTest2.phrase); // 'hello world'
    print(keyExtractSuriTest2.path.length); // 1
    print(keyExtractSuriTest2.path[0].isHard); // false
    print(keyExtractSuriTest2.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest3 = keyExtractSuri('hello world/DOT');
    print(keyExtractSuriTest3.password); // ''
    print(keyExtractSuriTest3.phrase); // 'hello world'
    print(keyExtractSuriTest3.path.length); // 1
    print(keyExtractSuriTest3.path[0].isHard); // false
    print(keyExtractSuriTest3.path[0]
        .chainCode); // Uint8List.fromList([12, 68, 79, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest4 = keyExtractSuri('hello world//1');
    print(keyExtractSuriTest4.password); // ''
    print(keyExtractSuriTest4.phrase); // 'hello world'
    print(keyExtractSuriTest4.path.length); // 1
    print(keyExtractSuriTest4.path[0].isHard); // true
    print(keyExtractSuriTest4.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest5 = keyExtractSuri('hello world//DOT');
    print(keyExtractSuriTest5.password); // ''
    print(keyExtractSuriTest5.phrase); // 'hello world'
    print(keyExtractSuriTest5.path.length); // 1
    print(keyExtractSuriTest5.path[0].isHard); // true
    print(keyExtractSuriTest5.path[0]
        .chainCode); // Uint8List.fromList([12, 68, 79, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest6 = keyExtractSuri('hello world//1/DOT');
    print(keyExtractSuriTest6.password); // ''
    print(keyExtractSuriTest6.phrase); // 'hello world'
    print(keyExtractSuriTest6.path.length); // 2
    print(keyExtractSuriTest6.path[0].isHard); // true
    print(keyExtractSuriTest6.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    print(keyExtractSuriTest6.path[1].isHard); // false
    print(keyExtractSuriTest6.path[1]
        .chainCode); // Uint8List.fromList([12, 68, 79, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest7 = keyExtractSuri('hello world//DOT/1');
    print(keyExtractSuriTest7.password); // ''
    print(keyExtractSuriTest7.phrase); // 'hello world'
    print(keyExtractSuriTest7.path.length); // 2
    print(keyExtractSuriTest7.path[0].isHard); // false
    print(keyExtractSuriTest7.path[0]
        .chainCode); // Uint8List.fromList([12, 68, 79, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    print(keyExtractSuriTest7.path[1].isHard); // true
    print(keyExtractSuriTest7.path[1]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest8 = keyExtractSuri('hello world///password');
    print("\n");
    print(keyExtractSuriTest8.password); // 'password'
    print(keyExtractSuriTest8.phrase); // 'hello world'
    print(keyExtractSuriTest8.path.length); // 0

    var keyExtractSuriTest9 = keyExtractSuri('hello world//1/DOT///password');
    print("\n");
    print(keyExtractSuriTest9.password); // 'password'
    print(keyExtractSuriTest9.phrase); // 'hello world'
    print(keyExtractSuriTest9.path.length); // 0
    print(keyExtractSuriTest9.path[0].isHard); // true
    print(keyExtractSuriTest9.path[0]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    print(keyExtractSuriTest9.path[1].isHard); // false
    print(keyExtractSuriTest9.path[1]
        .chainCode); // Uint8List.fromList([12, 68, 79, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

    var keyExtractSuriTest10 = keyExtractSuri(
        'bottom drive obey lake curtain smoke basket hold race lonely fit walk//Alice/1///password');
    print("\n");
    print(keyExtractSuriTest10.password); // 'password'
    print(keyExtractSuriTest10
        .phrase); // 'bottom drive obey lake curtain smoke basket hold race lonely fit walk world'
    print(keyExtractSuriTest10.path.length); // 2
    print(keyExtractSuriTest10.path[0].isHard); // true
    print(keyExtractSuriTest10.path[0]
        .chainCode); // Uint8List.fromList([20, 65, 108, 105, 99, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
    print(keyExtractSuriTest10.path[1].isHard); // false
    print(keyExtractSuriTest10.path[1]
        .chainCode); // Uint8List.fromList([1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])

  } catch (e) {
    throw e;
  }

  try {
    print("\n");
    print("----- schnorrkel");
    const tests = [
      [
        'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about',
        '0x00000000000000000000000000000000',
        '0x44e9d125f037ac1d51f0a7d3649689d422c2af8b1ec8e00d71db4d7bf6d127e33f50c3d5c84fa3e5399c72d6cbbbbc4a49bf76f76d952f479d74655a2ef2d453',
        '0xb0b3174fe43c15938bb0d0cc5b6f7ac7295f557ee1e6fdeb24fb73f4e0cb2b6ec40ffb9da4af6d411eae8e292750fd105ff70fe93f337b5b590f5a9d9030c750'
      ],
      [
        'legal winner thank year wave sausage worth useful legal winner thank yellow',
        '0x7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f',
        '0x4313249608fe8ac10fd5886c92c4579007272cb77c21551ee5b8d60b780416850f1e26c1f4b8d88ece681cb058ab66d6182bc2ce5a03181f7b74c27576b5c8bf',
        '0x20666c9dd63c5b04a6a14377579af14aba60707752d134726304d0804992e26f9092c47fbb9e14c02fd53c702c8a3cfca4735638599da5c4362e0d0560dceb58'
      ],
      [
        'letter advice cage absurd amount doctor acoustic avoid letter advice cage above',
        '0x80808080808080808080808080808080',
        '0x27f3eb595928c60d5bc91a4d747da40ed236328183046892ed6cd5aa9ae38122acd1183adf09a89839acb1e6eaa7fb563cc958a3f9161248d5a036e0d0af533d',
        '0x709e8254d0a9543c6b35b145dd23349e6369d487a1d10b0cfe09c05ff521f4691ad8bb8221339af38fc48510ec2dfc3104bb94d38f1fa241ceb252943df7b6b5'
      ],
      [
        'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo wrong',
        '0xffffffffffffffffffffffffffffffff',
        '0x227d6256fd4f9ccaf06c45eaa4b2345969640462bbb00c5f51f43cb43418c7a753265f9b1e0c0822c155a9cabc769413ecc14553e135fe140fc50b6722c6b9df',
        '0x88206f4b4102ad30ee40b4b5943c5259db77fd576d95d79eeea00160197e406308821814dea9442675a5d3fa375b3bd65ffe92be43e07dbf6bb4ab84e9d4449d'
      ],
      [
        'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon agent',
        '0x000000000000000000000000000000000000000000000000',
        '0x44e9d125f037ac1d51f0a7d3649689d422c2af8b1ec8e00d71db4d7bf6d127e33f50c3d5c84fa3e5399c72d6cbbbbc4a49bf76f76d952f479d74655a2ef2d453',
        '0xb0b3174fe43c15938bb0d0cc5b6f7ac7295f557ee1e6fdeb24fb73f4e0cb2b6ec40ffb9da4af6d411eae8e292750fd105ff70fe93f337b5b590f5a9d9030c750'
      ],
      [
        'legal winner thank year wave sausage worth useful legal winner thank year wave sausage worth useful legal will',
        '0x7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f',
        '0xcb1d50e14101024a88905a098feb1553d4306d072d7460e167a60ccb3439a6817a0afc59060f45d999ddebc05308714733c9e1e84f30feccddd4ad6f95c8a445',
        '0x50dcb74f223740d6a256000a2f1ccdb60044b39ce3aad71a3bd7761848d5f55d5a34f96e0b96ecb45d7a142e07ddfde734f9525f9f88310ab50e347da5789d3e'
      ],
      [
        'letter advice cage absurd amount doctor acoustic avoid letter advice cage absurd amount doctor acoustic avoid letter always',
        '0x808080808080808080808080808080808080808080808080',
        '0x9ddecf32ce6bee77f867f3c4bb842d1f0151826a145cb4489598fe71ac29e3551b724f01052d1bc3f6d9514d6df6aa6d0291cfdf997a5afdb7b6a614c88ab36a',
        '0x88112947a30e864b511838b6daf6e1e13801ae003d6d9b73eb5892c355f7e37ab3bb71200092d004467b06fe67bc153ee4e2bb7af2f544815b0dde276d2dae75'
      ],
      [
        'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo when',
        '0xffffffffffffffffffffffffffffffffffffffffffffffff',
        '0x8971cb290e7117c64b63379c97ed3b5c6da488841bd9f95cdc2a5651ac89571e2c64d391d46e2475e8b043911885457cd23e99a28b5a18535fe53294dc8e1693',
        '0x4859cdeda3f957b7ffcd2d59257c30e43996796f38e1be5c6136c9bf3744e047ce9a52c11793c98d0dc8caee927576ce46ef2e5f4b3f1d5e4b1344b2c31ebe8e'
      ],
      [
        'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon art',
        '0x0000000000000000000000000000000000000000000000000000000000000000',
        '0x44e9d125f037ac1d51f0a7d3649689d422c2af8b1ec8e00d71db4d7bf6d127e33f50c3d5c84fa3e5399c72d6cbbbbc4a49bf76f76d952f479d74655a2ef2d453',
        '0xb0b3174fe43c15938bb0d0cc5b6f7ac7295f557ee1e6fdeb24fb73f4e0cb2b6ec40ffb9da4af6d411eae8e292750fd105ff70fe93f337b5b590f5a9d9030c750'
      ],
      [
        'legal winner thank year wave sausage worth useful legal winner thank year wave sausage worth useful legal winner thank year wave sausage worth title',
        '0x7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f',
        '0x3037276a5d05fcd7edf51869eb841bdde27c574dae01ac8cfb1ea476f6bea6ef57ab9afe14aea1df8a48f97ae25b37d7c8326e49289efb25af92ba5a25d09ed3',
        '0xe8962ace15478f69fa42ddd004aad2c285c9f5a02e0712860e83fbec041f89489046aa57b21db2314d93aeb4a2d7cbdab21d4856e8e151894abd17fb04ae65e1'
      ],
      [
        'letter advice cage absurd amount doctor acoustic avoid letter advice cage absurd amount doctor acoustic avoid letter advice cage absurd amount doctor acoustic bless',
        '0x8080808080808080808080808080808080808080808080808080808080808080',
        '0x2c9c6144a06ae5a855453d98c3dea470e2a8ffb78179c2e9eb15208ccca7d831c97ddafe844ab933131e6eb895f675ede2f4e39837bb5769d4e2bc11df58ac42',
        '0x78667314bf1e52e38d29792cdf294efcaddadc4fa9ce48c5f2bef4daad7ed95d1db960d6f6f895c1a9d2a3ddcc0398ba6578580ea1f03f65ea9a68e97cf3f840'
      ],
      [
        'zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo zoo vote',
        '0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
        '0x047e89ef7739cbfe30da0ad32eb1720d8f62441dd4f139b981b8e2d0bd412ed4eb14b89b5098c49db2301d4e7df4e89c21e53f345138e56a5e7d63fae21c5939',
        '0xe09f4ae0d4e22f6c9bbc4251c880e73d93d10fdf7f152c393ce36e4e942b3155a6f4b48e6c6ebce902a10d4ab46ef59cd154c15aeb8f7fcd4e1e26342d40806d'
      ],
      [
        'ozone drill grab fiber curtain grace pudding thank cruise elder eight picnic',
        '0x9e885d952ad362caeb4efe34a8e91bd2',
        '0xf4956be6960bc145cdab782e649a5056598fd07cd3f32ceb73421c3da27833241324dc2c8b0a4d847eee457e6d4c5429f5e625ece22abaa6a976e82f1ec5531d',
        '0xb0eb046f48eacb7ad6c4da3ff92bfc29c9ad471bae3e554d5d63e58827160c70c7e5165598761f96b5659ab28c474f50e89ee13c67e30bca40fdcf4335835649'
      ],
      [
        'gravity machine north sort system female filter attitude volume fold club stay feature office ecology stable narrow fog',
        '0x6610b25967cdcca9d59875f5cb50b0ea75433311869e930b',
        '0xfbcc5229ade0c0ff018cb7a329c5459f91876e4dde2a97ddf03c832eab7f26124366a543f1485479c31a9db0d421bda82d7e1fe562e57f3533cb1733b001d84d',
        '0xd8da734285a13967647dd906288e1ac871e1945d0c6b72fa259de4051a9b75431be0c4eb40b1ca38c780f445e3e2809282b9efef4dcc3538355e68094f1e79fa'
      ],
      [
        'hamster diagram private dutch cause delay private meat slide toddler razor book happy fancy gospel tennis maple dilemma loan word shrug inflict delay length',
        '0x68a79eaca2324873eacc50cb9c6eca8cc68ea5d936f98787c60c7ebc74e6ce7c',
        '0x7c60c555126c297deddddd59f8cdcdc9e3608944455824dd604897984b5cc369cad749803bb36eb8b786b570c9cdc8db275dbe841486676a6adf389f3be3f076',
        '0x883b72fa7fb06b6abd0fc2cdb0018b3578e086e93074256bbbb8c68e53c04a56391bc0d19d7b2fa22a8148ccbe191d969c4323faca1935a576cc1b24301f203a'
      ],
      [
        'scheme spot photo card baby mountain device kick cradle pact join borrow',
        '0xc0ba5a8e914111210f2bd131f3d5e08d',
        '0xc12157bf2506526c4bd1b79a056453b071361538e9e2c19c28ba2cfa39b5f23034b974e0164a1e8acd30f5b4c4de7d424fdb52c0116bfc6a965ba8205e6cc121',
        '0x7039a64150089f8d43188af964c7b8e2b8c9ba20aede085baca5672e978a47576c7193c3e557f37cdeeee5e5131b854e4309efc55259b050474e1f0884a7a621'
      ],
      [
        'horn tenant knee talent sponsor spell gate clip pulse soap slush warm silver nephew swap uncle crack brave',
        '0x6d9be1ee6ebd27a258115aad99b7317b9c8d28b6d76431c3',
        '0x23766723e970e6b79dec4d5e4fdd627fd27d1ee026eb898feb9f653af01ad22080c6f306d1061656d01c4fe9a14c05f991d2c7d8af8730780de4f94cd99bd819',
        '0xe07a1f3073edad5b63585cdf1d5e6f8e50e3145de550fc8eb1fb430cce62d76d251904272c5d25fd634615d413bb31a2bc7b5d6eeb2f6ddc68a2b95ac6bd49bc'
      ],
      [
        'panda eyebrow bullet gorilla call smoke muffin taste mesh discover soft ostrich alcohol speed nation flash devote level hobby quick inner drive ghost inside',
        '0x9f6a2878b2520799a44ef18bc7df394e7061a224d2c33cd015b157d746869863',
        '0xf4c83c86617cb014d35cd87d38b5ef1c5d5c3d58a73ab779114438a7b358f457e0462c92bddab5a406fe0e6b97c71905cf19f925f356bc673ceb0e49792f4340',
        '0x607f8595266ac0d4aa91bf4fddbd2a868889317f40099979be9743c46c418976e6ff3717bd11b94b418f91c8b88eae142cecb19104820997ddf5a379dd9da5ae'
      ],
      [
        'cat swing flag economy stadium alone churn speed unique patch report train',
        '0x23db8160a31d3e0dca3688ed941adbf3',
        '0x719d4d4de0638a1705bf5237262458983da76933e718b2d64eb592c470f3c5d222e345cc795337bb3da393b94375ff4a56cfcd68d5ea25b577ee9384d35f4246',
        '0xd078b66bb357f1f06e897a6fdfa2f3dfb0da05836ded1fd0793373068b7e854e783a548a6d194f142e1ba78bf42a49fa58e3673b363ba6f6494efffa28f168df'
      ],
      [
        'light rule cinnamon wrap drastic word pride squirrel upgrade then income fatal apart sustain crack supply proud access',
        '0x8197a4a47f0425faeaa69deebc05ca29c0a5b5cc76ceacc0',
        '0x7ae1291db32d16457c248567f2b101e62c5549d2a64cd2b7605d503ec876d58707a8d663641e99663bc4f6cc9746f4852e75e7e54de5bc1bd3c299c9a113409e',
        '0x5095fe4d0144b06e82aa4753d595fd10de9bba3733eba8ce0784417182317e725fac31b2fb53f4856a5e38866501425b485f4d2eaf2666a9f20ae68f4331ed2c'
      ],
      [
        'all hour make first leader extend hole alien behind guard gospel lava path output census museum junior mass reopen famous sing advance salt reform',
        '0x066dca1a2bb7e8a1db2832148ce9933eea0f3ac9548d793112d9a95c9407efad',
        '0xa911a5f4db0940b17ecb79c4dcf9392bf47dd18acaebdd4ef48799909ebb49672947cc15f4ef7e8ef47103a1a91a6732b821bda2c667e5b1d491c54788c69391',
        '0x8844cb50f3ba8030ab61afee623534836d4ea3677d42bae470fc5e251ea0ca7ec9ea65c8c40be191c7c8683165848279ced81f3a121c9450078a496b6c59f610'
      ],
      [
        'vessel ladder alter error federal sibling chat ability sun glass valve picture',
        '0xf30f8c1da665478f49b001d94c5fc452',
        '0x4e2314ca7d9eebac6fe5a05a5a8d3546bc891785414d82207ac987926380411e559c885190d641ff7e686ace8c57db6f6e4333c1081e3d88d7141a74cf339c8f',
        '0x18917f0c7480c95cd4d98bdc7df773c366d33590252707da1358eb58b43a7b765e3c513878541bfbfb466bb4206f581edf9bf601409c72afac130bcc8b5661b5'
      ],
      [
        'scissors invite lock maple supreme raw rapid void congress muscle digital elegant little brisk hair mango congress clump',
        '0xc10ec20dc3cd9f652c7fac2f1230f7a3c828389a14392f05',
        '0x7a83851102849edc5d2a3ca9d8044d0d4f00e5c4a292753ed3952e40808593251b0af1dd3c9ed9932d46e8608eb0b928216a6160bd4fc775a6e6fbd493d7c6b2',
        '0xb0bf86b0955413fc95144bab124e82042d0cce9c292c1bfd0874ae5a95412977e7bc109aeef33c7c90be952a83f3fe528419776520de721ef6ec9e814749c3fc'
      ],
      [
        'void come effort suffer camp survey warrior heavy shoot primary clutch crush open amazing screen patrol group space point ten exist slush involve unfold',
        '0xf585c11aec520db57dd353c69554b21a89b20fb0650966fa0a9d6f74fd989d8f',
        '0x938ba18c3f521f19bd4a399c8425b02c716844325b1a65106b9d1593fbafe5e0b85448f523f91c48e331995ff24ae406757cff47d11f240847352b348ff436ed',
        '0xc07ba4a979657576f4f7446e3bd2672c87131fa0f472a8bc1f2e9b28c11fb04c66da12cd280662196a5888d8a77178dab8034ed42b11d1654a31db6e1ff4d4c5'
      ]
    ];
    var test2 = stringToU8a('12345678901234567890123456789012');
    var result2 = {
      "publicKey": Uint8List.fromList([
        116,
        28,
        8,
        160,
        111,
        65,
        197,
        150,
        96,
        143,
        103,
        116,
        37,
        155,
        217,
        4,
        51,
        4,
        173,
        250,
        93,
        62,
        234,
        98,
        118,
        11,
        217,
        190,
        151,
        99,
        77,
        99
      ]),
      "secretKey": Uint8List.fromList([
        240,
        16,
        102,
        96,
        195,
        221,
        162,
        63,
        22,
        218,
        169,
        172,
        91,
        129,
        27,
        150,
        48,
        119,
        245,
        188,
        10,
        248,
        159,
        133,
        128,
        79,
        13,
        232,
        228,
        36,
        240,
        80,
        249,
        141,
        102,
        243,
        148,
        66,
        80,
        111,
        249,
        71,
        253,
        145,
        31,
        24,
        199,
        167,
        165,
        218,
        99,
        154,
        99,
        232,
        211,
        180,
        226,
        51,
        247,
        65,
        67,
        217,
        81,
        193
      ])
    };

    // schnorrkelKeypairFromSeed(test2);
    print(schnorrkelKeypairFromSeed(test2).toJson() == json.encode(result2));

    tests.forEach((t) {
      var seed = mnemonicToMiniSecret(t[0], 'Substrate');
      var pair = schnorrkelKeypairFromSeed(seed);
      print(u8aToHex(pair.secretKey) == t[3]);
    });

    var schnorrkelMessage = stringToU8a('this is a message');

    var kp = schnorrkelKeypairFromSeed(randomAsU8a());
    var schnorrkelSig = schnorrkelSign(schnorrkelMessage, kp);
    print(schnorrkelSig.length == 64);
    print(schnorrkelVerify(schnorrkelMessage, schnorrkelSig, kp.publicKey));
  } catch (e) {
    throw e;
  }
}
