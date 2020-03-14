import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:flare_flutter/asset_provider.dart' show AssetProvider;
import 'package:flare_flutter/flare_render_box.dart' show FlareRenderBox;
import 'package:flare_flutter/flare.dart' show ActorAnimation, FlutterActor;
import 'package:flare_flutter/provider/asset_flare.dart' show AssetFlare;
import 'package:flare_dart/math/mat2d.dart' show Mat2D;
import 'package:flare_dart/math/aabb.dart' show AABB;

import '../helpers/pseudo3D_actor.dart';

class RivePseudo3DWidget extends LeafRenderObjectWidget {
  const RivePseudo3DWidget({
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.point,
    this.turn,
    this.depth,
  });

  final Alignment alignment;
  final double point, turn, depth;
  final BoxFit fit;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RivePseudo3DRenderObject()
      ..fit = fit
      ..alignment = alignment
      ..point = point
      ..turn = turn
      ..pseudo3DDepth = depth;
  }

  @override
  void didUnmountRenderObject(
          covariant RivePseudo3DRenderObject _renderObject) =>
      _renderObject.dispose();

  @override
  void updateRenderObject(
      BuildContext context, covariant RivePseudo3DRenderObject renderObject) {
    renderObject
      ..fit = fit
      ..alignment = alignment
      ..point = point
      ..turn = turn
      ..pseudo3DDepth = depth;
  }
}

class RivePseudo3DRenderObject extends FlareRenderBox {
  double _animationTime = 0.0, point, turn, pseudo3DDepth;
  Pseudo3DArtboard _artboard;
  final AssetProvider _foreground =
      AssetFlare(bundle: rootBundle, name: 'assets/animations/foreground.flr');

  ActorAnimation _writing;

  @override
  bool get isPlaying => true;

  @override
  AABB get aabb => _artboard?.artboardAABB();

  @override
  void advance(double elapsed) {
    if (_artboard == null) {return;}
    _animationTime += elapsed;
    _writing?.apply(_animationTime % _writing.duration, _artboard, 1.0);
    _artboard.setPseudo3D(point, turn, pseudo3DDepth);
    _artboard.advance(elapsed);
  }

  @override
  void load() {
    super.load();
    loadFlare(_foreground).then(
      (FlutterActor actor) {
        Pseudo3DArtboard artboard = Pseudo3DActor.instanceArtboard(actor);
        artboard.initializeGraphics();
        _artboard = artboard;
        _writing = _artboard.getAnimation('dribbble');
        _artboard.advance(0.0);
        markNeedsPaint();
      },
    );
  }

  @override
  void paintFlare(Canvas canvas, Mat2D viewTransform) => _artboard.draw(canvas);
}
