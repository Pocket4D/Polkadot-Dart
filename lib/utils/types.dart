import 'dart:convert';

class Time {
  Time({
    required this.days,
    required this.hours,
    required this.milliseconds,
    required this.minutes,
    required this.seconds,
  });

  final int days;
  final int hours;
  final int milliseconds;
  final int minutes;
  final int seconds;

  Time copyWith({
    int? days,
    int? hours,
    int? milliseconds,
    int? minutes,
    int? seconds,
  }) =>
      Time(
        days: days ?? this.days,
        hours: hours ?? this.hours,
        milliseconds: milliseconds ?? this.milliseconds,
        minutes: minutes ?? this.minutes,
        seconds: seconds ?? this.seconds,
      );

  factory Time.fromJson(String str) => Time.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Time.fromMap(Map<String, dynamic> json) => Time(
        days: json["days"],
        hours: json["hours"],
        milliseconds: json["milliseconds"],
        minutes: json["minutes"],
        seconds: json["seconds"],
      );

  Map<String, dynamic> toMap() => {
        "days": days,
        "hours": hours,
        "milliseconds": milliseconds,
        "minutes": minutes,
        "seconds": seconds,
      };
}
