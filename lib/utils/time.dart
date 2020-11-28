import 'package:polkadot_dart/utils/types.dart';

const HRS = 60 * 60;
const DAY = HRS * 24;

const zero = {"days": 0, "hours": 0, "milliseconds": 0, "minutes": 0, "seconds": 0};

Time extractTime(num milliseconds) {
  if (milliseconds == 0 || milliseconds == null) {
    return Time.fromMap(zero);
  } else if (milliseconds < 1000) {
    return Time.fromMap(zero).copyWith(milliseconds: milliseconds.toInt());
  }
  return extractSecs(milliseconds);
}

Time addTime(Time a, Time b) {
  return Time.fromMap({
    "days": a.days + b.days,
    "hours": a.hours + b.hours,
    "milliseconds": a.milliseconds + b.milliseconds,
    "minutes": a.minutes + b.minutes,
    "seconds": a.seconds + b.seconds
  });
}

Time extractDays(num milliseconds, num hrs) {
  var days = (hrs / 24).floor();
  var zeroCopy = Time.fromMap(zero).copyWith(days: days);
  return addTime(zeroCopy, extractTime(milliseconds - (days * DAY * 1000)));
}

Time extractHrs(num milliseconds, num mins) {
  var hrs = mins / 60;
  if (hrs < 24) {
    var hours = (hrs).floor();
    var zeroCopy = Time.fromMap(zero).copyWith(hours: hours);
    return addTime(zeroCopy, extractTime(milliseconds - (hours * HRS * 1000)));
  }
  return extractDays(milliseconds, hrs);
}

Time extractMins(num milliseconds, num secs) {
  var mins = secs / 60;
  if (mins < 60) {
    var minutes = (mins).floor();
    var zeroCopy = Time.fromMap(zero).copyWith(minutes: minutes);
    return addTime(zeroCopy, extractTime(milliseconds - (minutes * 60 * 1000)));
  }

  return extractHrs(milliseconds, mins);
}

Time extractSecs(num milliseconds) {
  var secs = milliseconds / 1000;
  if (secs < 60) {
    var seconds = (secs).floor();
    var zeroCopy = Time.fromMap(zero).copyWith(seconds: seconds);
    return addTime(zeroCopy, extractTime(milliseconds - (seconds * 1000)));
  }

  return extractMins(milliseconds, secs);
}
