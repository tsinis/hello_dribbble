import 'dart:ui' as ui;
import 'package:flare_dart/actor_artboard.dart';
import 'package:flare_dart/actor_shape.dart';
import 'package:flare_dart/actor_image.dart';
import "package:flare_flutter/flare.dart";
import 'package:flutter/material.dart';

class Pseudo3DActor extends FlutterActor {
  Pseudo3DActor(FlutterActor source) {
    copyFlutterActor(source);
  }

  static Pseudo3DArtboard instanceArtboard(FlutterActor source) {
    Pseudo3DActor pseudo3DActor = Pseudo3DActor(source);
    return source.artboard.makeInstanceWithActor(pseudo3DActor)
        as Pseudo3DArtboard;
  }

  @override
  ActorShape makeShapeNode(source) => Pseudo3DActorShape();

  @override
  ActorImage makeImageNode() => Pseudo3DActorImage();

  @override
  ActorArtboard makeArtboard() => Pseudo3DArtboard(this);
}

class Pseudo3DArtboard extends FlutterActorArtboard {
  Pseudo3DArtboard(FlutterActor actor) : super(actor);

  void setPseudo3D(double point, double roll, double pseudo3DDepth) {
    Matrix4 transform = Matrix4.identity();
    Matrix4 perspective = Matrix4.identity()..setEntry(3, 2, 0.001);
    transform.multiply(Matrix4.diagonal3Values(0.6, 0.6, 1));
    transform.multiply(perspective);
    transform.multiply(Matrix4.rotationY(roll));
    transform.multiply(Matrix4.rotationX(point));

    var rootChildren = root.children;
    for (final drawable in drawableNodes) {
      if (drawable is Pseudo3DDrawable) {
        ActorNode topComponent = drawable;
        int index = 0;

        while (topComponent != null) {
          if (topComponent.parent == root) {
            index = rootChildren.length - rootChildren.indexOf(topComponent);
            break;
          }
          topComponent = topComponent.parent;
        }

        Matrix4 pseudo3DTransform = Matrix4.copy(transform);
        pseudo3DTransform.multiply(Matrix4.translationValues(
            0, 0, -100 - index * 35 * pseudo3DDepth * 4));
        (drawable as Pseudo3DDrawable).pseudo3DTransform = pseudo3DTransform;
      }
    }
  }
}

class Pseudo3DDrawable {
  Matrix4 pseudo3DTransform;
}

class Pseudo3DActorShape extends FlutterActorShape implements Pseudo3DDrawable {
  @override
  Matrix4 pseudo3DTransform;

  @override
  void draw(ui.Canvas canvas) {
    if (!doesDraw) {
      return;
    }

    canvas.save();
    canvas.transform(pseudo3DTransform.storage);
    super.draw(canvas);
    canvas.restore();
  }
}

class Pseudo3DActorImage extends FlutterActorImage implements Pseudo3DDrawable {
  @override
  Matrix4 pseudo3DTransform;

  @override
  void draw(ui.Canvas canvas) {
    if (!doesDraw) {
      return;
    }

    canvas.save();
    canvas.transform(pseudo3DTransform.storage);
    super.draw(canvas);
    canvas.restore();
  }
}
