// GENERATED CODE - DO NOT MODIFY BY HAND
// Consider adding this file to your .gitignore.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';


import 'settings/view/settings_dialog_test.dart' as settings_view_settings_dialog_test_dart;
import 'settings/bloc/settings/settings_bloc_test.dart' as settings_bloc_settings_settings_bloc_test_dart;
import 'settings/bloc/settings/settings_event_test.dart' as settings_bloc_settings_settings_event_test_dart;
import 'settings/bloc/settings/settings_state_test.dart' as settings_bloc_settings_settings_state_test_dart;
import 'loading/cubit/preload/preload_state_test.dart' as loading_cubit_preload_preload_state_test_dart;
import 'loading/cubit/preload/preload_cubit_test.dart' as loading_cubit_preload_preload_cubit_test_dart;
import 'loading/view/loading_page_test.dart' as loading_view_loading_page_test_dart;
import 'app/view/app_test.dart' as app_view_app_test_dart;
import 'app/view/game_viewport_test.dart' as app_view_game_viewport_test_dart;
import 'title/view/title_page_test.dart' as title_view_title_page_test_dart;
import 'game/spawners/food_spawner_test.dart' as game_spawners_food_spawner_test_dart;
import 'game/spawners/unicorn_spawner_test.dart' as game_spawners_unicorn_spawner_test_dart;
import 'game/behaviors/double_tap_behavior_test.dart' as game_behaviors_double_tap_behavior_test_dart;
import 'game/behaviors/positional_priority_behavior_test.dart' as game_behaviors_positional_priority_behavior_test_dart;
import 'game/view/game_page_test.dart' as game_view_game_page_test_dart;
import 'game/very_good_ranch_game_test.dart' as game_very_good_ranch_game_test_dart;
import 'game/widgets/footer_widget_test.dart' as game_widgets_footer_widget_test_dart;
import 'game/entities/food/food_test.dart' as game_entities_food_food_test_dart;
import 'game/entities/food/behaviors/dragging_behavior_test.dart' as game_entities_food_behaviors_dragging_behavior_test_dart;
import 'game/entities/food/behaviors/moving_to_inventory_behavior_test.dart' as game_entities_food_behaviors_moving_to_inventory_behavior_test_dart;
import 'game/entities/food/behaviors/despawning_behavior_test.dart' as game_entities_food_behaviors_despawning_behavior_test_dart;
import 'game/entities/unicorn/unicorn_test.dart' as game_entities_unicorn_unicorn_test_dart;
import 'game/entities/unicorn/behaviours/moving_behavior_test.dart' as game_entities_unicorn_behaviours_moving_behavior_test_dart;
import 'game/entities/unicorn/behaviours/petting_behavior_test.dart' as game_entities_unicorn_behaviours_petting_behavior_test_dart;
import 'game/entities/unicorn/behaviours/enjoyment_decreasing_behavior_test.dart' as game_entities_unicorn_behaviours_enjoyment_decreasing_behavior_test_dart;
import 'game/entities/unicorn/behaviours/evolving_behavior_test.dart' as game_entities_unicorn_behaviours_evolving_behavior_test_dart;
import 'game/entities/unicorn/behaviours/fullness_decresing_behavior_test.dart' as game_entities_unicorn_behaviours_fullness_decresing_behavior_test_dart;
import 'game/entities/unicorn/behaviours/food_colliding_behavior_test.dart' as game_entities_unicorn_behaviours_food_colliding_behavior_test_dart;
import 'game/entities/unicorn/behaviours/leaving_behavior_test.dart' as game_entities_unicorn_behaviours_leaving_behavior_test_dart;
import 'game/bloc/blessing/blessing_state_test.dart' as game_bloc_blessing_blessing_state_test_dart;
import 'game/bloc/blessing/blessing_bloc_test.dart' as game_bloc_blessing_blessing_bloc_test_dart;
import 'game/bloc/blessing/blessing_event_test.dart' as game_bloc_blessing_blessing_event_test_dart;
import 'game/bloc/game/game_state_test.dart' as game_bloc_game_game_state_test_dart;
import 'game/bloc/game/game_event_test.dart' as game_bloc_game_game_event_test_dart;
import 'game/bloc/game/game_bloc_test.dart' as game_bloc_game_game_bloc_test_dart;
import 'inventory/view/inventory_dialog_test.dart' as inventory_view_inventory_dialog_test_dart;
import 'inventory/widgets/food_item_entry_test.dart' as inventory_widgets_food_item_entry_test_dart;
import 'inventory/bloc/inventory/inventory_state_test.dart' as inventory_bloc_inventory_inventory_state_test_dart;
import 'inventory/bloc/inventory/inventory_bloc_test.dart' as inventory_bloc_inventory_inventory_bloc_test_dart;
import 'inventory/bloc/inventory/inventory_event_test.dart' as inventory_bloc_inventory_inventory_event_test_dart;
import 'credits/view/credits_dialog_test.dart' as credits_view_credits_dialog_test_dart;

void main() {
  goldenFileComparator = _TestOptimizationAwareGoldenFileComparator();
  group('settings_view_settings_dialog_test_dart', settings_view_settings_dialog_test_dart.main);
  group('settings_bloc_settings_settings_bloc_test_dart', settings_bloc_settings_settings_bloc_test_dart.main);
  group('settings_bloc_settings_settings_event_test_dart', settings_bloc_settings_settings_event_test_dart.main);
  group('settings_bloc_settings_settings_state_test_dart', settings_bloc_settings_settings_state_test_dart.main);
  group('loading_cubit_preload_preload_state_test_dart', loading_cubit_preload_preload_state_test_dart.main);
  group('loading_cubit_preload_preload_cubit_test_dart', loading_cubit_preload_preload_cubit_test_dart.main);
  group('loading_view_loading_page_test_dart', loading_view_loading_page_test_dart.main);
  group('app_view_app_test_dart', app_view_app_test_dart.main);
  group('app_view_game_viewport_test_dart', app_view_game_viewport_test_dart.main);
  group('title_view_title_page_test_dart', title_view_title_page_test_dart.main);
  group('game_spawners_food_spawner_test_dart', game_spawners_food_spawner_test_dart.main);
  group('game_spawners_unicorn_spawner_test_dart', game_spawners_unicorn_spawner_test_dart.main);
  group('game_behaviors_double_tap_behavior_test_dart', game_behaviors_double_tap_behavior_test_dart.main);
  group('game_behaviors_positional_priority_behavior_test_dart', game_behaviors_positional_priority_behavior_test_dart.main);
  group('game_view_game_page_test_dart', game_view_game_page_test_dart.main);
  group('game_very_good_ranch_game_test_dart', game_very_good_ranch_game_test_dart.main);
  group('game_widgets_footer_widget_test_dart', game_widgets_footer_widget_test_dart.main);
  group('game_entities_food_food_test_dart', game_entities_food_food_test_dart.main);
  group('game_entities_food_behaviors_dragging_behavior_test_dart', game_entities_food_behaviors_dragging_behavior_test_dart.main);
  group('game_entities_food_behaviors_moving_to_inventory_behavior_test_dart', game_entities_food_behaviors_moving_to_inventory_behavior_test_dart.main);
  group('game_entities_food_behaviors_despawning_behavior_test_dart', game_entities_food_behaviors_despawning_behavior_test_dart.main);
  group('game_entities_unicorn_unicorn_test_dart', game_entities_unicorn_unicorn_test_dart.main);
  group('game_entities_unicorn_behaviours_moving_behavior_test_dart', game_entities_unicorn_behaviours_moving_behavior_test_dart.main);
  group('game_entities_unicorn_behaviours_petting_behavior_test_dart', game_entities_unicorn_behaviours_petting_behavior_test_dart.main);
  group('game_entities_unicorn_behaviours_enjoyment_decreasing_behavior_test_dart', game_entities_unicorn_behaviours_enjoyment_decreasing_behavior_test_dart.main);
  group('game_entities_unicorn_behaviours_evolving_behavior_test_dart', game_entities_unicorn_behaviours_evolving_behavior_test_dart.main);
  group('game_entities_unicorn_behaviours_fullness_decresing_behavior_test_dart', game_entities_unicorn_behaviours_fullness_decresing_behavior_test_dart.main);
  group('game_entities_unicorn_behaviours_food_colliding_behavior_test_dart', game_entities_unicorn_behaviours_food_colliding_behavior_test_dart.main);
  group('game_entities_unicorn_behaviours_leaving_behavior_test_dart', game_entities_unicorn_behaviours_leaving_behavior_test_dart.main);
  group('game_bloc_blessing_blessing_state_test_dart', game_bloc_blessing_blessing_state_test_dart.main);
  group('game_bloc_blessing_blessing_bloc_test_dart', game_bloc_blessing_blessing_bloc_test_dart.main);
  group('game_bloc_blessing_blessing_event_test_dart', game_bloc_blessing_blessing_event_test_dart.main);
  group('game_bloc_game_game_state_test_dart', game_bloc_game_game_state_test_dart.main);
  group('game_bloc_game_game_event_test_dart', game_bloc_game_game_event_test_dart.main);
  group('game_bloc_game_game_bloc_test_dart', game_bloc_game_game_bloc_test_dart.main);
  group('inventory_view_inventory_dialog_test_dart', inventory_view_inventory_dialog_test_dart.main);
  group('inventory_widgets_food_item_entry_test_dart', inventory_widgets_food_item_entry_test_dart.main);
  group('inventory_bloc_inventory_inventory_state_test_dart', inventory_bloc_inventory_inventory_state_test_dart.main);
  group('inventory_bloc_inventory_inventory_bloc_test_dart', inventory_bloc_inventory_inventory_bloc_test_dart.main);
  group('inventory_bloc_inventory_inventory_event_test_dart', inventory_bloc_inventory_inventory_event_test_dart.main);
  group('credits_view_credits_dialog_test_dart', credits_view_credits_dialog_test_dart.main);
}


class _TestOptimizationAwareGoldenFileComparator extends LocalFileComparator {
  final List<String> goldenFilePaths;

  _TestOptimizationAwareGoldenFileComparator()
      : goldenFilePaths = _goldenFilePaths,
        super(_testFile);

  static Uri get _testFile {
    final basedir =
        (goldenFileComparator as LocalFileComparator).basedir.toString();
    return Uri.parse("$basedir/.test_runner.dart");
  }

  static List<String> get _goldenFilePaths =>
      Directory.fromUri((goldenFileComparator as LocalFileComparator).basedir)
          .listSync(recursive: true, followLinks: true)
          .whereType<File>()
          .map((file) => file.path)
          .where((path) => path.endsWith('.png'))
          .toList();

  @override
  Uri getTestUri(Uri key, int? version) {
    final keyString = key.path;
    return Uri.parse(goldenFilePaths
        .singleWhere((goldenFilePath) => goldenFilePath.endsWith(keyString)));
  }
}
