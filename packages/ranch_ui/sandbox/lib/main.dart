import 'package:dashbook/dashbook.dart';
import 'package:flutter/material.dart';

import 'package:sandbox/stories/stories.dart';

void main() {
  final dashbook = Dashbook(theme: ThemeData.light());
  addBoardButtonStories(dashbook);
  addProgressBarStories(dashbook);
  runApp(dashbook);
}
