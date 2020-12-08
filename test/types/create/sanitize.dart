import 'package:flutter_test/flutter_test.dart';
import 'package:polkadot_dart/types/create/sanitize.dart';
// import 'package:polkadot_dart/utils/utils.dart'; // use extendsion methods for fast data format converting

void main() {
  sanitizeTest(); // rename this test name
}

void sanitizeTest() {
  group('alias', () {
    final exec = alias(['String'], 'Text');
    test('replaces all occurrences for types', () {
      expect(exec('(String,Address,MasterString,String)'), '(Text,Address,MasterString,Text)');
    });
    test('replaces actual types, but leaves struct names', () {
      expect(exec('{"system":"String","versionString":"String"}'),
          '{"system":"Text","versionString":"Text"}');
    });
    test('handles the preceding correctly', () {
      // NOTE This type doesn't make sense
      expect(exec('String String (String,[String;32],String)"String<String>'),
          'Text Text (Text,[Text;32],Text)"Text<Text>');
    });
    test('handles emdedded Vec/Tuples', () {
      final ann = alias(['Announcement'], 'ProxyAnnouncement');
      expect(ann('(Vec<Announcement>,BalanceOf)'), '(Vec<ProxyAnnouncement>,BalanceOf)');
    });
  });

  group('removeColons', () {
    test('removes preceding ::Text -> Text', () {
      expect(removeColons()('::Text'), 'Text');
    });

    test('removes middle voting::TallyType -> TallyType', () {
      expect(removeColons()('voting::TallyType'), 'TallyType');
    });

    test('removes on embedded values (one)', () {
      expect(removeColons()('(T::AccountId, SpanIndex)'), '(AccountId, SpanIndex)');
    });

    test('removes on embedded values (all)', () {
      expect(removeColons()('(T::AccountId, slashing::SpanIndex)'), '(AccountId, SpanIndex)');
    });

    test('keeps with allowNamespaces', () {
      expect(removeColons()('::slashing::SpanIndex', SanitizeOptions(allowNamespaces: true)),
          'slashing::SpanIndex');
    });
  });
}
