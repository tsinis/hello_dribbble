import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart' show FlareActor;

import 'widgets/appbar.dart';
import 'helpers/ik_controller.dart';
import 'widgets/pseudo3D_widget.dart';

class HelloDribblePage extends StatefulWidget {
  const HelloDribblePage();

  @override
  _MyHelloDribblePageState createState() => _MyHelloDribblePageState();
}

class _MyHelloDribblePageState extends State<HelloDribblePage>
    with SingleTickerProviderStateMixin {
  Animation<double> _pseudo3D, _depth;
  final IKController _ikController = IKController();
  double _point = 0.0, _turn = 0.0;
  AnimationController _ticketController;

  @override
  void initState() {
    super.initState();

    _ticketController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(
        () => setState(
          () {
            if (_pseudo3D != null) {
              _point *= _pseudo3D.value;
              _turn *= _pseudo3D.value;
            }
          },
        ),
      );
    _ticketController.forward(from: 1.0);
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(height: 30.0, width: _size.width),
      backgroundColor: const Color(0xffe07ba4),
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails drag) {
          _point += drag.delta.dy * (1 / _size.height);
          _turn -= drag.delta.dx * (1 / _size.width);
          setState(
            () => _ikController.moveBall(
              Offset(
                  drag.localPosition.dx.clamp(
                    ((_size.width <= _size.height)
                        ? _size.width * 0.1
                        : ((_size.width / 2) - (_size.height / 2) * 0.7)),
                    ((_size.width <= _size.height)
                        ? _size.width * 0.9
                        : (_size.width / 2 + (_size.height / 2) * 0.7)),
                  ),
                  0.0),
            ),
          );
        },
        onPanEnd: (DragEndDetails _details) {
          _pseudo3D = Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(_ticketController);
          _depth = Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(
            CurvedAnimation(
              parent: _ticketController,
              curve: const Cubic(0.5, 0, 0.25, 1.0),
            ),
          );
          _ticketController.forward();
        },
        onPanStart: (DragStartDetails _details) {
          _pseudo3D = null;
          _depth = Tween<double>(
            begin: 1.0,
            end: 0.0,
          ).animate(
            CurvedAnimation(
              parent: _ticketController,
              curve: const Cubic(1.0, 0.0, 1.0, 1.0),
            ),
          );
          _ticketController.reverse();
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: FlareActor(
                'assets/background.flr',
                animation: 'jumping',
                controller: _ikController,
              ),
            ),
            Positioned.fill(
              child: RivePseudo3DWidget(
                point: _point,
                turn: _turn,
                depth: _depth?.value ?? 0.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
