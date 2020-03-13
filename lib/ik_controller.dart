import 'dart:ui';

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_dart/math/mat2d.dart' show Mat2D;
import 'package:flare_dart/math/vec2d.dart' show Vec2D;
import 'package:flutter/widgets.dart' show ValueNotifier;

class IKController implements FlareController {
  Offset _screenTouch;
  Mat2D _viewTransform;
  ActorNode _aimTarget;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    if (_aimTarget == null || _screenTouch == null || _viewTransform == null) {
      return false;
    }

    Mat2D inverseViewTransform = Mat2D();
    if (!Mat2D.invert(inverseViewTransform, _viewTransform)) {
      return true;
    }

    Vec2D worldTouch = Vec2D();
    Vec2D.transformMat2D(worldTouch, Vec2D.fromValues(_screenTouch.dx, 0.0),
        inverseViewTransform);

    Mat2D inverseTargetWorld = Mat2D();
    if (!Mat2D.invert(inverseTargetWorld, _aimTarget.parent.worldTransform)) {
      return true;
    }

    Vec2D localTouchCoordinates = Vec2D();
    Vec2D.transformMat2D(localTouchCoordinates, worldTouch, inverseTargetWorld);

    _aimTarget.translation = localTouchCoordinates;
    return true;
  }

  @override
  void initialize(FlutterActorArtboard artboard) {
    _aimTarget = artboard.getNode('inverse_kinematic');
  }

  void moveBall(Offset offset) {
    _screenTouch = offset;
  }

  void setViewTransform(Mat2D viewTransform) {
    _viewTransform = viewTransform;
  }

  @override
  ValueNotifier<bool> isActive;
}
