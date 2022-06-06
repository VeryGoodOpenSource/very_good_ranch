import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ranch_components/gen/assets.gen.dart';
import 'package:very_good_ranch/game/entities/entities.dart';

class UnicornCounter extends PositionComponent with HasGameRef {
  UnicornCounter({
    required super.position,
  });

  @override
  PositionType get positionType => PositionType.game;

  late List<Unicorn> unicorns;

  @override
  Future<void> onLoad() async {
    gameRef.children.register<Unicorn>();
    unicorns = gameRef.children.query<Unicorn>();

    await addAll(UnicornStage.values.map(_UnicornHead.new));
  }
}

class _UnicornHead extends Component with ParentIsA<UnicornCounter> {
  _UnicornHead(this.stage);

  static final _textPaint = TextPaint(
    style: GoogleFonts.mouseMemoirs(
      color: Colors.black,
      fontSize: 24,
    ),
    textDirection: TextDirection.rtl,
  );

  final UnicornStage stage;

  late Sprite _head;

  @override
  Future<void> onLoad() async {
    // TODO(wolfen): when we have more sprites this should be based on stage.
    _head = await parent.gameRef.loadSprite(
      Assets.images.childSprite.packagePath,
      srcSize: Vector2(11, 11),
      srcPosition: Vector2(18, 4),
    );
  }

  @override
  void render(Canvas canvas) {
    final multiplier = [
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
    final size = _head.srcSize * 2;
    final position = Vector2(-8, 0);

    canvas
      ..save()
      ..translate(0, textSize.y * multiplier + 8);

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
