import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/codec.dart';
import 'package:polkadot_dart/types/primitives/primitives.dart';
import 'package:polkadot_dart/types/types/codec.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// var regJson={
//     'BitVec': BitVec,
//     'Option<BitVec>': Option<BitVec>,
//     'Vec<BitVec>': Vec<BitVec>,
//     'bool': CodecBool,
//     'Option<bool>': Option<CodecBool>,
//     'Vec<bool>': Vec<CodecBool>,
//     'Bool': CodecBool,
//     'Option<Bool>': Option<CodecBool>,
//     'Vec<Bool>': Vec<CodecBool>,
//     'Bytes': Bytes,
//     'Option<Bytes>': Option<Bytes>,
//     'Vec<Bytes>': Vec<Bytes>,
//     'Data': Data,
//     'Option<Data>': Option<Data>,
//     'Vec<Data>': Vec<Data>,
//     'DoNotConstruct': DoNotConstruct,
//     'Option<DoNotConstruct>': Option<DoNotConstruct>,
//     'Vec<DoNotConstruct>': Vec<DoNotConstruct>,
//     'i8': i8,
//     'Option<i8>': Option<i8>,
//     'Vec<i8>': Vec<i8>,
//     'I8': i8,
//     'Option<I8>': Option<i8>,
//     'Vec<I8>': Vec<i8>,
//     'i16': i16,
//     'Option<i16>': Option<i16>,
//     'Vec<i16>': Vec<i16>,
//     'I16': i16,
//     'Option<I16>': Option<i16>,
//     'Vec<I16>': Vec<i16>,
//     'i32': i32,
//     'Option<i32>': Option<i32>,
//     'Vec<i32>': Vec<i32>,
//     'I32': i32,
//     'Option<I32>': Option<i32>,
//     'Vec<I32>': Vec<i32>,
//     'i64': i64,
//     'Option<i64>': Option<i64>,
//     'Vec<i64>': Vec<i64>,
//     'I64': i64,
//     'Option<I64>': Option<i64>,
//     'Vec<I64>': Vec<i64>,
//     'i128': i128,
//     'Option<i128>': Option<i128>,
//     'Vec<i128>': Vec<i128>,
//     'I128': i128,
//     'Option<I128>': Option<i128>,
//     'Vec<I128>': Vec<i128>,
//     'i256': i256,
//     'Option<i256>': Option<i256>,
//     'Vec<i256>': Vec<i256>,
//     'I256': i256,
//     'Option<I256>': Option<i256>,
//     'Vec<I256>': Vec<i256>,
//     'CodecNull': CodecNull,
//     'Option<CodecNull>': Option<CodecNull>,
//     'Vec<CodecNull>': Vec<CodecNull>,
//     'StorageKey': StorageKey,
//     'Option<StorageKey>': Option<StorageKey>,
//     'Vec<StorageKey>': Vec<StorageKey>,
//     'CodecText': CodecText,
//     'Option<CodecText>': Option<CodecText>,
//     'Vec<CodecText>': Vec<CodecText>,
//     'Type': CodecType,
//     'Option<Type>': Option<CodecType>,
//     'Vec<Type>': Vec<CodecType>,
//     'u8': u8,
//     'Compact<u8>': Compact<u8>,
//     'Option<u8>': Option<u8>,
//     'Vec<u8>': Vec<u8>,
//     'U8': u8,
//     'Compact<U8>': Compact<u8>,
//     'Option<U8>': Option<u8>,
//     'Vec<U8>': Vec<u8>,
//     'u16': u16,
//     'Compact<u16>': Compact<u16>,
//     'Option<u16>': Option<u16>,
//     'Vec<u16>': Vec<u16>,
//     'U16': u16,
//     'Compact<U16>': Compact<u16>,
//     'Option<U16>': Option<u16>,
//     'Vec<U16>': Vec<u16>,
//     'u32': u32,
//     'Compact<u32>': Compact<u32>,
//     'Option<u32>': Option<u32>,
//     'Vec<u32>': Vec<u32>,
//     'U32': u32,
//     'Compact<U32>': Compact<u32>,
//     'Option<U32>': Option<u32>,
//     'Vec<U32>': Vec<u32>,
//     'u64': u64,
//     'Compact<u64>': Compact<u64>,
//     'Option<u64>': Option<u64>,
//     'Vec<u64>': Vec<u64>,
//     'U64': u64,
//     'Compact<U64>': Compact<u64>,
//     'Option<U64>': Option<u64>,
//     'Vec<U64>': Vec<u64>,
//     'u128': u128,
//     'Compact<u128>': Compact<u128>,
//     'Option<u128>': Option<u128>,
//     'Vec<u128>': Vec<u128>,
//     'U128': u128,
//     'Compact<U128>': Compact<u128>,
//     'Option<U128>': Option<u128>,
//     'Vec<U128>': Vec<u128>,
//     'u256': u256,
//     'Compact<u256>': Compact<u256>,
//     'Option<u256>': Option<u256>,
//     'Vec<u256>': Vec<u256>,
//     'U256': u256,
//     'Compact<U256>': Compact<u256>,
//     'Option<U256>': Option<u256>,
//     'Vec<U256>': Vec<u256>,
//     'usize': usize,
//     'Compact<usize>': Compact<usize>,
//     'Option<usize>': Option<usize>,
//     'Vec<usize>': Vec<usize>,
//     'USize': usize,
//     'Compact<USize>': Compact<usize>,
//     'Option<USize>': Option<usize>,
//     'Vec<USize>': Vec<usize>,
//     'Json': Json,
//     'Option<Json>': Option<Json>,
//     'Vec<Json>': Vec<Json>,
//     'Raw': Raw,
//     'Option<Raw>': Option<Raw>,
//     'Vec<Raw>': Vec<Raw>,
// }

class Regs {
  Map<String, dynamic> typeMaps;
  Regs() {
    typeMaps = Map<String, Constructor>()
      ..addEntries([
        // MapEntry('Option<BitVec>', Option.create as OptionConstuctor<BitVec>),
        MapEntry('Option<Json>', Option.constructor),
        MapEntry('Option<BitVec>', Option.constructor)
      ]);
  }
}