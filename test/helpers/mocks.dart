import 'package:bloc_test/bloc_test.dart';
import 'package:very_good_ranch/settings/settings.dart';

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}
