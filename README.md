# p4d_rust_binding

A rust binding and dart libraries for crypto projects, providing reliable and stable implementation by rust libs.

It is a sub-project of `Pocket4D`, and used in `Wallet4D` and `Pocket4D` internally.
It will be published to [pub.dev](https://pub.dev) as flutter plugin, and re-used by other projects.

it is aiming to support:

* Substrate/Polkadot
* Bitcoin
* Ethereum
* Zilliqa
* Harmony
* Oasis Protocol
* other blockchains


## Build manually

```bash
./scripts/clean.sh && ./scripts/init.sh && ./scripts/build.sh
```


## Documents
TBD


## TODO-List
### bindings
[x] bindings
[x] ffi_base
[x] ffi_helpers

### crypto
[x] common
[x] crypto
[x] ed25519
[x] secp256k1
[x] sr25519
[x] util

### direct
[x] iapi
[x] ifunction
[x] imodule
[x] irpc_function
[x] irpc_module
[x] isection

### keyring
[ ] pair
[ ] types
[ ] ...

### rpc
[x] core_irpc
[x] json_author
[x] json_chain
[x] json_rpc
[x] json_state
[x] json_system
[x] types

### types
[ ] codec

### util_crypto
[ ] address
[x] base32
[x] base58
[ ] base64
[x] blake2
[ ] ethereum
[ ] keccek
[x] key
[x] mnemonic
[x] nacl
[ ] pbkdf2
[x] random
[x] schnorrkel
[x] scrypt
[x] secp256k1
[ ] sha512
[ ] signature
[ ] types
[ ] xxhash

### utils
[x] bn
[x] compact
[x] extension
[x] format
[x] hex
[x] is
[x] logger
[x] metadata
[x] si
[x] string
[x] time
[x] types
[x] u8a
[x] utils

### tests
all [x]s above are done






