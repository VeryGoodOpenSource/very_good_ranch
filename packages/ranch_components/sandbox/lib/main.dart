import 'package:dashbook/dashbook.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/stories/gauge_component/stories.dart';
import 'package:sandbox/stories/stories.dart';
import 'package:sandbox/stories/unicorn_component/stories.dart';

void main() {
  final dashbook = Dashbook(theme: ThemeData.light());

  addUnicornComponentStories(dashbook);
  addFoodComponentStories(dashbook);
  addGaugeComponentStories(dashbook);

  runApp(dashbook);
}
