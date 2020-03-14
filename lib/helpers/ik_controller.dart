import 'dart:ui';

import 'package:flutter/material.dart' show ValueNotifier;

import 'package:flare_flutter/flare.dart';
import 'package:flare_flutter/flare_controller.dart';
import 'package:flare_dart/math/mat2d.dart' show Mat2D;
import 'package:flare_dart/math/vec2d.dart' show Vec2D;

class IKController implements FlareController {
  ActorNode _ikTarget;
  Offset _screenTouch;
  Mat2D _viewTransform;

  @override
  ValueNotifier<bool> isActive;

  @override
  bool advance(FlutterActorArtboard artboard, double elapsed) {
    if (_ikTarget == null || _screenTouch == null || _viewTransform == null) {
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
    if (!Mat2D.invert(inverseTargetWorld, _ikTarget.parent.worldTransform)) {
      return true;
    }

    Vec2D localTouchCoordinates = Vec2D();
    Vec2D.transformMat2D(localTouchCoordinates, worldTouch, inverseTargetWorld);

    _ikTarget.translation = localTouchCoordinates;
    return true;
  }

  @override
  void initialize(FlutterActorArtboard _artboard) =>
      _ikTarget = _artboard.getNode('inverse_kinematic');

  void moveBall(Offset _offset) => _screenTouch = _offset;

  void setViewTransform(Mat2D viewTransform) => _viewTransform = viewTransform;
}
