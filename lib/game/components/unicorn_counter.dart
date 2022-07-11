import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:very_good_ranch/game/entities/entities.dart';
import 'package:very_good_ranch/game/very_good_ranch_game.dart';
import 'package:very_good_ranch/gen/assets.gen.dart';

class UnicornCounter extends PositionComponent
    with HasGameRef<VeryGoodRanchGame> {
  UnicornCounter({
    required super.position,
  });

  late List<Unicorn> unicorns;

  @override
  Future<void> onLoad() async {
    gameRef.background.children.register<Unicorn>();
    unicorns = gameRef.background.children.query<Unicorn>();

    await addAll(UnicornEvolutionStage.values.map(_UnicornHead.new));
  }
}

class _UnicornHead extends Component with ParentIsA<UnicornCounter> {
  _UnicornHead(this.evolutionStage);

  static final _textPaint = TextPaint(
    style: GoogleFonts.mouseMemoirs(
      color: Colors.white,
      fontSize: 24,
      height: 1.2,
    ),
    textDirection: TextDirection.rtl,
  );

  final UnicornEvolutionStage evolutionStage;

  late Sprite _head;

  @override
  Future<void> onLoad() async {
    _head = await parent.gameRef.loadSprite(
      evolutionStage.headAssetPath,
      srcSize: Vector2(40, 40),
    );
  }

  @override
  void render(Canvas canvas) {
    final multiplier = const [
      UnicornEvolutionStage.baby,
      UnicornEvolutionStage.child,
      UnicornEvolutionStage.teen,
      UnicornEvolutionStage.adult
    ].indexOf(evolutionStage);
    final amount = parent.unicorns
        .where((u) => u.isMounted && u.evolutionStage == evolutionStage)
        .length;
    final textSize = _textPaint.measureText('$amount');

    const anchor = Anchor.topRight;
    final size = _head.srcSize * 0.8;
    final position = Vector2(-8, 0);

    canvas
      ..save()
      ..translate(0, (textSize.y + 5) * multiplier + 10);

    _textPaint.render(
      canvas,
      '$amount',
      Vector2(-size.x + position.x - 8, 0),
      anchor: anchor,
    );

    _head.render(canvas, size: size, position: position, anchor: anchor);
    canvas.restore();
  }
}

extension on UnicornEvolutionStage {
  String get headAssetPath {
    switch (this) {
      case UnicornEvolutionStage.baby:
        return Assets.images.babyHead.path;
      case UnicornEvolutionStage.child:
        return Assets.images.childHead.path;
      case UnicornEvolutionStage.teen:
        return Assets.images.teenHead.path;
      case UnicornEvolutionStage.adult:
        return Assets.images.adultHead.path;
    }
  }
}
