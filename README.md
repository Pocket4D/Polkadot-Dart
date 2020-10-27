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


## Project Structure
1. `/rust/lib`, lib entries
2. `/rust/crypto`, crypto entries
3. `/rust/${blockchain}`, blockchain specific wrapper
4. `/lib/p4d_rust_binding`, dart lib entries
5. `/lib/${blockchain}`, blockchain specific classes/abstracts
6. `/lib/utils`, common utilities for this libraries
7. `/test`, tests
8. `/examples`, examples for this lib

## Quick start
TBD

## Build manually

```bash
./scripts/clean.sh && ./scripts/init.sh && ./scripts/build.sh
```


## Documents
TBD






