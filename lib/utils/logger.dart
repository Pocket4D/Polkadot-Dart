import 'package:logger/logger.dart';

Logger logger = Logger(
  printer: PrefixPrinter(HybridPrinter(
      PrettyPrinter(methodCount: 0, colors: false, printTime: true, printEmojis: true),
      debug: SimplePrinter())), //OneLinePrinter(),
);
