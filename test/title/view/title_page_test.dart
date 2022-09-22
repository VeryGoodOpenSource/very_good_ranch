// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_sounds/ranch_sounds.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/loading/cubit/preload/preload_cubit.dart';
import 'package:very_good_ranch/settings/settings.dart';
import 'package:very_good_ranch/title/title.dart';

import '../../helpers/helpers.dart';

void main() {
  group('TitlePage', () {
    late PreloadCubit preloadCubit;
    late SettingsBloc settingsBloc;
    late MockRanchSoundPlayer sounds;

    setUp(() {
      sounds = MockRanchSoundPlayer();
      settingsBloc = MockSettingsBloc();
      preloadCubit = MockPreloadCubit();
      when(() => preloadCubit.sounds).thenReturn(sounds);
      when(() => sounds.play(RanchSound.sunsetMemory))
          .thenAnswer((Invocation invocation) async {});
      when(() => sounds.setVolume(RanchSound.sunsetMemory, any()))
          .thenAnswer((Invocation invocation) async {});
      when(() => sounds.stop(RanchSound.sunsetMemory))
          .thenAnswer((Invocation invocation) async {});

      whenListen(
        settingsBloc,
        const Stream<SettingsState>.empty(),
        initialState: SettingsState(),
      );
    });

    testWidgets('render correctly', (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));
      await tester.pumpApp(
        TitlePage(),
        preloadCubit: preloadCubit,
        settingsBloc: settingsBloc,
      );

      expect(find.byType(TitlePageSky), findsOneWidget);
      expect(find.byType(TitlePageGround), findsOneWidget);
      expect(find.byType(TitlePageMenu), findsOneWidget);

      expect(find.byType(BoardButton), findsNWidgets(2));
      expect(find.text(l10n.play), findsOneWidget);
      expect(find.text(l10n.settings), findsOneWidget);
    });

    testWidgets('tapping on play button navigates to GamePage', (tester) async {
      final l10n = await AppLocalizations.delegate.load(Locale('en'));
      final navigator = MockNavigator();
      when(() => navigator.pushReplacement<void, void>(any()))
          .thenAnswer((_) async {});

      await tester.pumpApp(
        TitlePage(),
        preloadCubit: preloadCubit,
        settingsBloc: settingsBloc,
        navigator: navigator,
      );

      await tester.tap(find.widgetWithText(BoardButton, l10n.play));

      verify(() => navigator.pushReplacement<void, void>(any())).called(1);
    });

    testWidgets(
      'tapping on settings button displays dialog with SettingsDialog',
      (tester) async {
        final settingsBloc = MockSettingsBloc();

        whenListen(
          settingsBloc,
          const Stream<SettingsState>.empty(),
          initialState: SettingsState(),
        );

        final l10n = await AppLocalizations.delegate.load(Locale('en'));
        await tester.pumpApp(
          TitlePage(),
          settingsBloc: settingsBloc,
          preloadCubit: preloadCubit,
        );

        await tester.tap(find.widgetWithText(BoardButton, l10n.settings));
        await tester.pump();

        expect(find.byType(SettingsDialog), findsOneWidget);
      },
    );
  });

  group('TitlePageSky', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpApp(TitlePageSky());

      await expectLater(
        find.byType(TitlePageSky),
        matchesGoldenFile('golden/sky.png'),
      );
    });
  });

  group('TitlePageGround', () {
    testWidgets('renders correctly on 3:4', (tester) async {
      await tester.pumpImageAssets(
        Center(
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: TitlePageGround(),
          ),
        ),
      );

      await expectLater(
        find.byType(TitlePageGround),
        matchesGoldenFile('golden/ground_3_4.png'),
      );
    });

    testWidgets('renders correctly on 9:21', (tester) async {
      await tester.pumpImageAssets(
        Center(
          child: AspectRatio(
            aspectRatio: 9 / 21,
            child: TitlePageGround(),
          ),
        ),
      );

      await expectLater(
        find.byType(TitlePageGround),
        matchesGoldenFile('golden/ground_9_21.png'),
      );
    });
  });
}

extension on WidgetTester {
  Future<void> pumpImageAssets(Widget widget) async {
    await runAsync(() async {
      await pumpApp(widget);
      for (final element in find.byType(Image).evaluate()) {
        final widget = element.widget as Image;
        final image = widget.image;
        await precacheImage(image, element);
        await pumpAndSettle();
      }
    });
  }
}
