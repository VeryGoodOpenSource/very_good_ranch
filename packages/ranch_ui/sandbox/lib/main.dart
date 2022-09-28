import 'package:dashbook/dashbook.dart';
import 'package:flutter/material.dart';
import 'package:sandbox/stories/modal/stories.dart';

import 'package:sandbox/stories/stories.dart';

void main() {
  final dashbook = Dashbook(theme: ThemeData.light());
  addModalStories(dashbook);
  addUnicornCounterStories(dashbook);
  addBoardButtonStories(dashbook);
  addProgressBarStories(dashbook);
  runApp(dashbook);
}
