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

  @override
  PositionType get positionType => PositionType.game;

  late List<Unicorn> unicorns;

  @override
  Future<void> onLoad() async {
    gameRef.background.children.register<Unicorn>();
    unicorns = gameRef.background.children.query<Unicorn>();

    await addAll(UnicornStage.values.map(_UnicornHead.new));
  }
}

class _UnicornHead extends Component with ParentIsA<UnicornCounter> {
  _UnicornHead(this.stage);

  static final _textPaint = TextPaint(
    style: GoogleFonts.mouseMemoirs(
      color: Colors.white,
      fontSize: 24,
      height: 1.2,
    ),
    textDirection: TextDirection.rtl,
  );

  final UnicornStage stage;

  late Sprite _head;

  @override
  Future<void> onLoad() async {
    _head = await parent.gameRef.loadSprite(
      stage.headAssetPath,
      srcSize: Vector2(40, 40),
    );
  }

  @override
  void render(Canvas canvas) {
    final multiplier = const [
      UnicornStage.baby,
      UnicornStage.child,
      UnicornStage.teen,
      UnicornStage.adult
    ].indexOf(stage);
    final amount = parent.unicorns
        .where((u) => u.isMounted && u.currentStage == stage)
        .length;
    final textSize = _textPaint.measureText(amount.toString());

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

extension on UnicornStage {
  String get headAssetPath {
    switch (this) {
      case UnicornStage.baby:
        return Assets.images.babyHead.path;
      case UnicornStage.child:
        return Assets.images.childHead.path;
      case UnicornStage.teen:
        return Assets.images.teenHead.path;
      case UnicornStage.adult:
        return Assets.images.adultHead.path;
    }
  }
}
