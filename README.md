# Polkadot-Dart

`Polkadot-Dart` is a Dart-lang library to use access API of Polkadot network.

This library contains a set of crypto libraries and implementations of utils.

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


## Development enviorment
* dart sdk: '>=2.7.0 < 3.0.0'
* flutter: '>=1.20.0 < 2.0.0'
* rust nightly latest
* MacOs or Linux


## Build manually  
* Build rust binding
```bash
./scripts/clean.sh && ./scripts/init.sh && ./scripts/build.sh
```

## Unit Tests
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









