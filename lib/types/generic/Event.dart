import 'dart:typed_data';

import 'package:polkadot_dart/types/codec/Tuple.dart';
import 'package:polkadot_dart/types/types/registry.dart';

// class GenericEventData extends Tuple {
//   // GenericEventData(Registry registry, Uint8List value, dynamic value) : super(registry, types, value);
//   // readonly #meta: EventMetadataLatest;

//   // readonly #method: string;

//   // readonly #section: string;

//   // readonly #typeDef: TypeDef[];

//   // constructor (registry: Registry, value: Uint8Array, Types: Constructor[] = [], typeDef: TypeDef[] = [], meta: RegistryMetadataEvent, section = '<unknown>', method = '<unknown>') {
//   //   super(registry, Types, value);

//   //   this.#meta = meta as EventMetadataLatest;
//   //   this.#method = method;
//   //   this.#section = section;
//   //   this.#typeDef = typeDef;
//   // }

//   // /**
//   //  * @description The wrapped [[EventMetadata]]
//   //  */
//   // get meta (): EventMetadataLatest {
//   //   return this.#meta;
//   // }

//   // /**
//   //  * @description The method as a string
//   //  */
//   // get method (): string {
//   //   return this.#method;
//   // }

//   // /**
//   //  * @description The section as a string
//   //  */
//   // get section (): string {
//   //   return this.#section;
//   // }

//   // /**
//   //  * @description The [[TypeDef]] for this event
//   //  */
//   // get typeDef (): TypeDef[] {
//   //   return this.#typeDef;
//   // }
// }

/**
 * @name GenericEvent
 * @description
 * A representation of a system event. These are generated via the [[Metadata]] interfaces and
 * specific to a specific Substrate runtime
 */
// class GenericEvent extends Struct {
//   // Currently we _only_ decode from Uint8Array, since we expect it to
//   // be used via EventRecord
//   constructor (registry: Registry, _value?: Uint8Array) {
//     const { DataType, value } = GenericEvent.decodeEvent(registry, _value);

//     super(registry, {
//       index: 'EventId',
//       // eslint-disable-next-line sort-keys
//       data: DataType
//     }, value);
//   }

//   /** @internal */
//   static decodeEvent (registry: Registry, value: Uint8Array = new Uint8Array()): { DataType: Constructor<Null> | Constructor<GenericEventData>; value?: { index: Uint8Array; data: Uint8Array } } {
//     if (!value.length) {
//       return { DataType: Null };
//     }

//     const index = value.subarray(0, 2);

//     return {
//       DataType: registry.findMetaEvent(index),
//       value: {
//         data: value.subarray(2),
//         index
//       }
//     };
//   }

//   /**
//    * @description The wrapped [[EventData]]
//    */
//   get data (): GenericEventData {
//     return this.get('data') as GenericEventData;
//   }

//   /**
//    * @description The [[EventId]], identifying the raw event
//    */
//   get index (): EventId {
//     return this.get('index') as EventId;
//   }

//   /**
//    * @description The [[EventMetadata]] with the documentation
//    */
//   get meta (): EventMetadataLatest {
//     return this.data.meta;
//   }

//   /**
//    * @description The method string identifying the event
//    */
//   get method (): string {
//     return this.data.method;
//   }

//   /**
//    * @description The section string identifying the event
//    */
//   get section (): string {
//     return this.data.section;
//   }

//   /**
//    * @description The [[TypeDef]] for the event
//    */
//   get typeDef (): TypeDef[] {
//     return this.data.typeDef;
//   }

//   /**
//    * @description Converts the Object to to a human-friendly JSON, with additional fields, expansion and formatting of information
//    */
//   toHuman (isExpanded?: boolean): Record<string, AnyJson> {
//     return {
//       method: this.method,
//       section: this.section,
//       ...(isExpanded
//         ? { documentation: this.meta.documentation.map((d) => d.toString()) }
//         : {}
//       ),
//       ...super.toHuman(isExpanded)
//     };
//   }
// }
