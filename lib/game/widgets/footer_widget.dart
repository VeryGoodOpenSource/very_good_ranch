import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ranch_ui/ranch_ui.dart';
import 'package:very_good_ranch/game/game.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({
    super.key,
    required this.game,
  });

  final FlameGame game;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 28,
      ).copyWith(top: 0),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _UnicornCounter(type: UnicornType.baby),
            SizedBox(width: 16),
            _UnicornCounter(type: UnicornType.child),
            SizedBox(width: 16),
            _UnicornCounter(type: UnicornType.teen),
            SizedBox(width: 16),
            _UnicornCounter(type: UnicornType.adult),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}

class _UnicornCounter extends StatelessWidget {
  const _UnicornCounter({
    required this.type,
  });

  final UnicornType type;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlessingBloc, BlessingState>(
      builder: (context, state) {
        final count = state.getUnicornCountForType(type);
        return UnicornCounter(
          isActive: count > 0,
          type: type,
          child: Text(count.toString()),
        );
      },
    );
  }
}

extension on BlessingState {
  int getUnicornCountForType(UnicornType type) {
    switch (type) {
      case UnicornType.baby:
        return babyUnicorns;
      case UnicornType.child:
        return childUnicorns;
      case UnicornType.teen:
        return teenUnicorns;
      case UnicornType.adult:
        return adultUnicorns;
    }
  }
}
