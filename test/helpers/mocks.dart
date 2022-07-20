import 'dart:math';

import 'package:bloc_test/bloc_test.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:very_good_ranch/game/bloc/bloc.dart';
import 'package:very_good_ranch/inventory/inventory.dart';
import 'package:very_good_ranch/l10n/l10n.dart';
import 'package:very_good_ranch/loading/cubit/cubit.dart';
import 'package:very_good_ranch/settings/settings.dart';

class MockSettingsBloc extends MockBloc<SettingsEvent, SettingsState>
    implements SettingsBloc {}

class MockGameBloc extends MockBloc<GameEvent, GameState> implements GameBloc {}

class MockInventoryBloc extends MockBloc<InventoryEvent, InventoryState>
    implements InventoryBloc {}

class MockRandom extends Mock implements Random {}

class MockAppLocalizations extends Mock implements AppLocalizations {}

class MockPreloadCubit extends MockCubit<PreloadState> implements PreloadCubit {
}
