import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flare_flutter/asset_provider.dart' show AssetProvider;
import 'package:flare_flutter/flare_render_box.dart' show FlareRenderBox;
import 'package:flare_flutter/flare.dart' show ActorAnimation, FlutterActor;
import 'package:flare_flutter/provider/asset_flare.dart' show AssetFlare;
import 'package:flare_dart/math/mat2d.dart' show Mat2D;
import 'package:flare_dart/math/aabb.dart' show AABB;

import 'pseudo3D_actor.dart';

class FlarePseudo3DWidget extends LeafRenderObjectWidget {
  final BoxFit fit;
  final Alignment alignment;

  final double point, turn, depth;

  const FlarePseudo3DWidget({
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.point,
    this.turn,
    this.depth,
  });

  @override
  RenderObject createRenderObject(BuildContext context) {
    return FlarePseudo3DRenderObject()
      ..fit = fit
      ..alignment = alignment
      ..point = point
      ..turn = turn
      ..pseudo3DDepth = depth;
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant FlarePseudo3DRenderObject renderObject) {
    renderObject
      ..fit = fit
      ..alignment = alignment
      ..point = point
      ..turn = turn
      ..pseudo3DDepth = depth;
  }

  @override
  void didUnmountRenderObject(
          covariant FlarePseudo3DRenderObject renderObject) =>
      renderObject.dispose();
}

class FlarePseudo3DRenderObject extends FlareRenderBox {
  Pseudo3DArtboard _artboard;
  double point, turn, pseudo3DDepth;
  static final AssetProvider foreground =
      AssetFlare(bundle: rootBundle, name: 'assets/foreground.flr');

  @override
  bool get isPlaying => true;
  ActorAnimation _writing;
  double _animationTime = 0.0;

  @override
  void advance(double elapsed) {
    if (_artboard == null) {
      return;
    }
    _animationTime += elapsed;
    _writing?.apply(_animationTime % _writing.duration, _artboard, 1);
    _artboard.setPseudo3D(point, turn, pseudo3DDepth);
    _artboard.advance(elapsed);
  }

  @override
  AABB get aabb => _artboard?.artboardAABB();

  @override
  void paintFlare(Canvas canvas, Mat2D viewTransform) {
    if (_artboard == null) {
      return;
    }
    _artboard.draw(canvas);
  }

  @override
  void load() {
    super.load();
    loadFlare(foreground).then((FlutterActor actor) {
      if (actor.artboard == null || actor == null) {
        return;
      }

      Pseudo3DArtboard artboard = Pseudo3DActor.instanceArtboard(actor);
      artboard.initializeGraphics();
      _artboard = artboard;
      _writing = _artboard.getAnimation('dribbble');
      _artboard.advance(0);
      markNeedsPaint();
    });
  }
}
