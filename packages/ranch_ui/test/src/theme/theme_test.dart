import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ranch_ui/src/theme/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('mainFontTextStyle is mouseMemoirs', () {
    final textStyle = RanchUITheme.mainFontTextStyle;
    expect(textStyle, GoogleFonts.mouseMemoirs());
  });
  test('minorFontTextStyle is anybody', () {
    final textStyle = RanchUITheme.minorFontTextStyle;
    expect(textStyle, GoogleFonts.anybody());
  });
  test('themeData', () {
    final themeData = RanchUITheme.themeData;
    expect(themeData, isA<ThemeData>);
  });
  test('setupFonts', () async {
    RanchUITheme.setupFonts();

    // load licenses
    final licenses = await LicenseRegistry.licenses.toList();
    expect(licenses.length, 2);

    // setups google fonts
    expect(GoogleFonts.config.allowRuntimeFetching, false);
  });
}
