import 'package:p4d_rust_binding/p4d_rust_binding.dart';

main() async {
  var phrase = "legal winner thank year wave sausage worth useful legal winner thank yellow";
  var password = "Substrate";
  var validate = bip39Validate(phrase);

  print("isValid Phrase: $validate \n");
  try {
    var miniSecret = bip39ToMiniSecret(phrase, password);
    print("miniSecret: $miniSecret  \n");
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
    print("blake2bHash32 equal expcted :${blake2bHash32 == blake2bExpected32}  \n");
    print("blake2bHash64 is :$blake2bHash64");
    print("blake2bHash64 equal expcted :${blake2bHash64 == blake2bExpected64}  \n");
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
    print("keccakHash equal expcted:${keccakHash == keccakExpected}  \n");
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
    print("pbkdf2Hash equal expcted:${pbkdf2Hash == pbkdf2Expected}  \n");
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
    print("scryptHash equal expcted:${scryptHash == scryptExpected}  \n");
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
    print("sha512Hash equal expcted:${sha512Hash == sha512Expected}  \n");
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
    print("twoxHash64 equal expcted:${twoxHash64 == twoxExpected64}  \n");
    print("twoxHash256 is :$twoxHash256");
    print("twoxHash256 equal expcted:${twoxHash256 == twoxExpected256}  \n");
  } catch (e) {
    print(e);
  }
}
