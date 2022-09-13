import 'package:dashbook/dashbook.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/stories/ranch_background_component/stories.dart';
import 'package:sandbox/stories/stories.dart';

void main() {
  final dashbook = Dashbook(theme: ThemeData.light());

  addGaugeComponentStories(dashbook);

  addBackgroundComponentStories(dashbook);

  addUnicornComponentStories(dashbook);

  addFoodComponentStories(dashbook);

  addClipComponentStories(dashbook);

  addConfettiComponentStories(dashbook);

  addEvolutionComponentStories(dashbook);

  addRainbowDropStories(dashbook);

  runApp(dashbook);
}
