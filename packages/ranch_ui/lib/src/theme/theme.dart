import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ranch_ui/gen/assets.gen.dart';

/// Theme related functions for the ranch UI
class RanchUITheme {
  /// Obtain a standard [ThemeData]
  static ThemeData get themeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: const MaterialColor(
          0x46B2A0,
          <int, Color>{
            50: Color(0xFF92DED3),
            100: Color(0xFF92DED3),
            200: Color(0xFF92DED3),
            300: Color(0xFF92DED3),
            400: Color(0xFF46B2A0),
            500: Color(0xFF46B2A0),
            600: Color(0xFF0D605F),
            700: Color(0xFF0D605F),
            800: Color(0xFF0D605F),
            900: Color(0xFF0D605F),
          },
        ),
        accentColor: const Color(0xFF0D605F),
      ),
      textTheme: GoogleFonts.mouseMemoirsTextTheme(),
      primaryTextTheme: GoogleFonts.anybodyTextTheme(),
    );
  }

  /// Perform the relevant configurations related to the fonts used in the
  /// Ranch UI.
  static void setupFonts() {
    // Add font licenses
    LicenseRegistry.addLicense(() async* {
      final mouseMemoirsLicense = await rootBundle.loadString(
        'packages/ranch_ui/${Assets.fonts.mouseMemoirs.ofl}',
      );
      yield LicenseEntryWithLineBreaks(['mouse_memoirs'], mouseMemoirsLicense);

      final anybodyLicense = await rootBundle.loadString(
        'packages/ranch_ui/${Assets.fonts.anybody.ofl}',
      );
      yield LicenseEntryWithLineBreaks(['anybody'], anybodyLicense);
    });

    GoogleFonts.config.allowRuntimeFetching = false;
  }

  /// Retrieve a [TextStyle] for the main ranch ui font.
  static TextStyle get mainFontTextStyle => GoogleFonts.mouseMemoirs();

  /// Retrieve a [TextStyle] for the minor ranch ui font.
  static TextStyle get minorFontTextStyle => GoogleFonts.anybody();
}
