# Polkadot-Dart

`Polkadot-Dart` is a Dart-lang library to use access API of Polkadot network.

This library contains a set of crypto libraries and implementations of utils.

---
## Table of content
1. [Polkadot-Dart](#polkadot-dart)
   1. [Table of content](#table-of-content)
   2. [Status](#status)
      1. [Milestone 1: finished](#milestone-1-finished)
      2. [Milestone 2: Under development](#milestone-2-under-development)
      3. [Milestone 3: Awaits](#milestone-3-awaits)
   3. [Manually Build](#manually-build)
      1. [Enviorment Settings](#enviorment-settings)
      2. [Read before build](#read-before-build)
      3. [LLVM and clang](#llvm-and-clang)
      4. [Flutter and Dart](#flutter-and-dart)
      5. [NDK and Android SDK](#ndk-and-android-sdk)
      6. [Everything you need for rust](#everything-you-need-for-rust)
      7. [Build rust lib to `.so` and `.a` manually](#build-rust-lib-to-so-and-a-manually)
   4. [Testing Guide](#testing-guide)
      1. [Run a single unit test](#run-a-single-unit-test)
      2. [Run all tests](#run-all-tests)
      3. [Coverage and null-safe tests](#coverage-and-null-safe-tests)
      4. [Integration tests](#integration-tests)
      5. [Mobile phone tests example](#mobile-phone-tests-example)
      6. [Generate coverage](#generate-coverage)

---
## Status

### Milestone 1: finished

| Status  | Number | Deliverable     | Specification                                  |
| ------- | ------ | --------------- | ---------------------------------------------- |
| &#9745; | 0      | Licence         | Apache 2.0                                     |
| &#9745; | 1      | bindings/crypto | Rust binding and implements `@polkadot/wasm`   |
| &#9745; | 2      | util_crypto     | Porting and implements `@polkadot/util-crypto` |
| &#9745; | 3      | utils           | Porting and implements `@polkadot/utils`       |
| &#9745; | 4      | keyring         | Porting and implements `@polkadot/keyring`     |
| &#9745; | 5      | networks        | Porting and implements `@polkadot/networks`    |
| &#9745; | 6      | tests           | Unit tests for deliverables above              |

### Milestone 2: Under development

| Status | Number | Deliverable  | Specification                                   |
| ------ | ------ | ------------ | ----------------------------------------------- |
| 60%    | 1      | types        | Porting `@polkadot/types`                       |
| 0%     | 2      | rpc_core     | Porting and implements `@polkadot/rpc`          |
| 0%     | 3      | rpc_provider | Porting and implements `@polkadot/rpc_provider` |
| 50%    | 4      | metadata     | Porting  `@polkadot/metadata`                   |
| 0%     | 5      | api_derive   | Porting  `@polkadot/api-derive`                 |
| 0%     | 6      | api_contract | Porting  `@polkadot/api-contract`               |
| 0%     | 7      | api          | Porting  `@polkadot/api`                        |
| 15%    | 8      | tests        | Unit tests for deliverables above               |
| 0%     | 9      | pub.dev      | Publish to pub.dev for v1.0.0-dev1              |

### Milestone 3: Awaits

| Status | Number | Deliverable    | Specification                        |
| ------ | ------ | -------------- | ------------------------------------ |
| 0%     | 1      | tests          | Integration tests for all milestones |
| 0%     | 2      | documentations | Documentations for all packages      |
| 0%     | 3      | pub.dev        | Publish to pub.dev for v1.0.0        |

---
## Manually Build
### Enviorment Settings
* dart sdk: '>=2.7.0 < 3.0.0'
* flutter: '>=1.20.0 < 2.0.0'
* rust nightly latest
* MacOs or Linux
  
There are a few settings that needed before manually build, here is the guide.
We will try to make a `.make` file afterwards to simply the process.

### Read before build
1. There are dynamic libs to be build during the process.
   
2. This repository use CI to generate dynamic libs, tests are ensured passed, better not build them yourself.



### LLVM and clang

With Macos (because we need to build iOS)

```bash
brew upgrade && brew install llvm
```

### Flutter and Dart
1. Follow [Download and Install guide](https://flutter.dev/docs/get-started/install)
2. Verify your flutter version and env settings, make sure everything works
   
    ```bash
    flutter doctor -v
    ```

### NDK and Android SDK
1. Android SDK(After Flutter is installed)
2. Download [NDK](https://developer.android.com/ndk/downloads) and set `NDK_HOME` to env.
   
    ```bash
    export NDK_HOME=~/ndk/android-ndk-r21b
    # or if you use `ndk-bundle` of Android SDK locally, for macos:
    export ANDROID_HOME=~/Library/Android/sdk
    export ANDROID_NDK_HOME=~/Library/Android/sdk/ndk-bundle
    export NDK_HOME=~/Library/Android/sdk/ndk-bundle

    # and for linux, its like
    export NDK_HOME=/home/${User}/dev/android/ndk-bundle
    ```

### Everything you need for rust
1. Install rust-lang and cargo, [install here](https://www.rust-lang.org/tools/install)
2. All others are in `/scripts` folder, the steps below are not neccesary , just in-case something's missing.
   
   * Install cargo-lipo(for ios building) and cbindgen
   ```bash
   cargo install cargo-lipo && cargo install --force cbindgen
   ```

   * Install Android and iOS targets:
   ```bash
   rustup target add aarch64-linux-android armv7-linux-androideabi x86_64-linux-android i686-linux-android aarch64-apple-ios x86_64-apple-ios
   ```

### Build rust lib to `.so` and `.a` manually  
1. Build rust binding
```bash
./scripts/clean.sh && ./scripts/init.sh && ./scripts/build.sh
```
2. You can locate files in the android and ios folder.
   * Android: `android/src/main/jniLibs/`
   * iOS:  `ios`
   * MacOS: `macos` (**Caution: Build it on macos only**)
   * Linux: `linux` (**Caution: Build it on linux only**)
   * Windows: `windows` (unavailable for now)

---
## Testing Guide
**Caution!! Do Not use `flutter test` directly**

### Run a single unit test
All test scripts are in `/test` folder. The folder structure matches the `lib` struture.

For example:
A `.dart` file name `hex.dart` 
In lib folder, that is `lib/utils/hex.dart`
In test folder, that is  `test/utils/hex.dart`
To test it, in root folder run `flutter test test/utils/hex.dart`

| lib folder           | test folder           | test script                        |
| -------------------- | --------------------- | ---------------------------------- |
| `lib/utils/hex.dart` | `test/utils/hex.dart` | `flutter test test/utils/hex.dart` |


### Run all tests
The `polkadot_dart_test.dart` is the entry of all unit tests, simply run:

`flutter test test/polkadot_dart_test.dart` 

### Coverage and null-safe tests
TODO

### Integration tests
TODO

### Mobile phone tests example
Later


### Generate coverage
```bash
$ ./scripts/runTest.sh
```






