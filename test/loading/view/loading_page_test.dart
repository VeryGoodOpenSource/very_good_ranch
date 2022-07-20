// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:ranch_flame/ranch_flame.dart';
import 'package:very_good_ranch/game/game.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/loading/loading.dart';
import 'package:very_good_ranch/settings/settings.dart';

import '../../helpers/helpers.dart';

void main() {
  group('LoadingPage', () {
    late PreloadCubit preloadCubit;

    setUp(() {
      preloadCubit = MockPreloadCubit();
      when(() => preloadCubit.images).thenReturn(UnprefixedImages());
    });
  });
}
