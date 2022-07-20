// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_ranch/app/app.dart';
import 'package:very_good_ranch/loading/loading.dart';

import '../../helpers/mocks.dart';

void main() {
  group('App', () {
    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(App());
      await tester.pumpAndSettle(Duration(seconds: 1));
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    testWidgets('renders LoadingPage', (tester) async {
      final preloadCubit = MockPreloadCubit();
      final initialState = PreloadState.initial();
      whenListen(
        preloadCubit,
        Stream.fromIterable([initialState]),
        initialState: initialState,
      );

      when(preloadCubit.loadSequentially).thenAnswer((invocation) async {});
      await tester.pumpWidget(
        BlocProvider<PreloadCubit>.value(
          value: preloadCubit,
          child: AppView(),
        ),
      );
      await tester.pump(Duration(milliseconds: 500));
      expect(find.byType(LoadingPage), findsOneWidget);
    });
  });
}
