// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_ranch/app/app.dart';
import 'package:very_good_ranch/title/title.dart';

void main() {
  group('App', () {
    testWidgets('renders TitlePage', (tester) async {
      await tester.pumpWidget(App());
      expect(find.byType(TitlePage), findsOneWidget);
    });
  });
}
