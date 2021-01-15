// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InterfacesLibraryGenerator
// **************************************************************************

part of 'builder.dart';

/// Period
class Period extends ITuple<BlockNumber, u32> {
  Period(Registry registry, BlockNumber item1, u32 item2) : super(item1, item2);
  factory Period.from(Period origin) => Period(origin.registry, origin.item1, origin.item2);

  @override
  Registry registry;

  @override
  cast<T extends BaseCodec>() {
    // TODO: implement cast
    throw UnimplementedError();
  }

  @override
  // TODO: implement encodedLength
  int get encodedLength => throw UnimplementedError();

  @override
  bool eq(other) {
    // TODO: implement eq
    throw UnimplementedError();
  }

  @override
  // TODO: implement hash
  H256 get hash => throw UnimplementedError();

  @override
  // TODO: implement isEmpty
  bool get isEmpty => throw UnimplementedError();

  @override
  String toHex([bool isLe]) {
    // TODO: implement toHex
    throw UnimplementedError();
  }

  @override
  toHuman([bool isExtended]) {
    // TODO: implement toHuman
    throw UnimplementedError();
  }

  @override
  toJSON() {
    // TODO: implement toJSON
    throw UnimplementedError();
  }

  @override
  String toRawType() {
    // TODO: implement toRawType
    throw UnimplementedError();
  }

  @override
  Uint8List toU8a([isBare]) {
    // TODO: implement toU8a
    throw UnimplementedError();
  }

  @override
  // TODO: implement value
  get value => throw UnimplementedError();
}

/// Priority
class Priority extends u8 {
  Priority(Registry registry, [dynamic value]) : super(registry, value);

  factory Priority.from(u8 origin) => Priority(origin.registry, origin.originValue);
}

/// SchedulePeriod
class SchedulePeriod extends Period {
  SchedulePeriod(Registry registry, [dynamic value]) : super(registry, value);

  factory SchedulePeriod.from(Period origin) => SchedulePeriod(origin.registry, origin.originValue);
}

/// SchedulePriority
class SchedulePriority extends Priority {
  SchedulePriority(Registry registry, [dynamic value]) : super(registry, value);

  factory SchedulePriority.from(Priority origin) =>
      SchedulePriority(origin.registry, origin.originValue);
}

/// Scheduled
class Scheduled extends Struct {
  Option<Bytes> get maybeId => super.getCodec("maybeId").cast<Option<Bytes>>();

  SchedulePriority get priority => super.getCodec("priority").cast<SchedulePriority>();

  Call get call => super.getCodec("call").cast<Call>();

  Option<SchedulePeriod> get maybePeriodic =>
      super.getCodec("maybePeriodic").cast<Option<SchedulePeriod>>();

  PalletsOrigin get origin => super.getCodec("origin").cast<PalletsOrigin>();

  Scheduled(Registry registry, [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "maybeId": "Option<Bytes>",
              "priority": "SchedulePriority",
              "call": "Call",
              "maybePeriodic": "Option<SchedulePeriod>",
              "origin": "PalletsOrigin"
            },
            value,
            jsonMap);

  factory Scheduled.from(Struct origin) =>
      Scheduled(origin.registry, origin.originValue, origin.originJsonMap);
}

/// ScheduledTo254
class ScheduledTo254 extends Struct {
  Option<Bytes> get maybeId => super.getCodec("maybeId").cast<Option<Bytes>>();

  SchedulePriority get priority => super.getCodec("priority").cast<SchedulePriority>();

  Call get call => super.getCodec("call").cast<Call>();

  Option<SchedulePeriod> get maybePeriodic =>
      super.getCodec("maybePeriodic").cast<Option<SchedulePeriod>>();

  ScheduledTo254(Registry registry,
      [dynamic value = "___defaultEmpty", Map<dynamic, String> jsonMap])
      : super(
            registry,
            {
              "maybeId": "Option<Bytes>",
              "priority": "SchedulePriority",
              "call": "Call",
              "maybePeriodic": "Option<SchedulePeriod>"
            },
            value,
            jsonMap);

  factory ScheduledTo254.from(Struct origin) =>
      ScheduledTo254(origin.registry, origin.originValue, origin.originJsonMap);
}

/// TaskAddress
class TaskAddress extends ITuple<BlockNumber, u32> {
  TaskAddress(Registry registry, [dynamic value]) : super(registry, value);

  factory TaskAddress.from(ITuple<BlockNumber, u32> origin) =>
      TaskAddress(origin.registry, origin.originValue);
}
