// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/loading/cubit/cubit.dart';
import 'package:very_good_ranch/loading/view/loading_page.dart';
import 'package:very_good_ranch/settings/settings.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingsBloc()),
        BlocProvider(create: (_) => InventoryBloc()),
        BlocProvider(create: (_) => GameBloc()),
        BlocProvider(create: (_) => PreloadCubit(UnprefixedImages()))
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
        textTheme: GoogleFonts.mouseMemoirsTextTheme(),
        primaryTextTheme: GoogleFonts.anybodyTextTheme(),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoadingPage(),
    );
  }
}
