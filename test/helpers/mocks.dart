import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/settings/settings.dart';

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

class MockRandom extends Mock implements Random {}
