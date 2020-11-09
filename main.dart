import 'package:p4d_rust_binding/p4d_rust_binding.dart';

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

    var blake2bData = "abc";
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
}
