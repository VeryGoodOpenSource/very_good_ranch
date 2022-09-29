// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:ranch_sounds/ranch_sounds.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/dialog/dialog.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/loading/loading.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingsBloc()),
        BlocProvider(create: (_) => BlessingBloc()),
        BlocProvider(
          create: (_) => PreloadCubit(
            UnprefixedImages(),
            RanchSoundPlayer(),
          )..loadSequentially(),
        )
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundSoundWidget(
      ranchSound: RanchSound.sunsetMemory,
      player: context.read<PreloadCubit>().sounds,
      volume: context.watch<SettingsBloc>().state.musicVolume,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: RanchUITheme.themeData,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const LoadingPage(),
      ),
    );
  }
}
