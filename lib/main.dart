import 'package:flare_flutter/flare_actor.dart' show FlareActor;
import 'package:flutter/material.dart';

import 'appbar.dart';
import 'ik_controller.dart';
import 'pseudo3D_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      MaterialApp(debugShowCheckedModeBanner: false, home: const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _ticketController;
  Animation<double> _pseudo3D, _depth;
  double _point = 0.0, _turn = 0.0;
  IKController _ikController = IKController();

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
      backgroundColor: const Color(0xffde7da4),
      body: GestureDetector(
        onPanUpdate: (DragUpdateDetails drag) {
          setState(() {
            _point += drag.delta.dy * (1 / _size.height);
            _turn -= drag.delta.dx * (1 / _size.width);
            _ikController.moveBall(
              Offset(
                  drag.localPosition.dx.clamp(
                    ((_size.width <= _size.height)
                        ? _size.width * 0.1
                        : ((_size.width / 2) - (_size.height / 2) * 0.8)),
                    ((_size.width <= _size.height)
                        ? _size.width * 0.9
                        : (_size.width / 2 + (_size.height / 2) * 0.8)),
                  ),
                  0.0),
            );
          });
        },
        onPanEnd: (DragEndDetails details) {
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
              curve: const Cubic(0.5, 0, 0.25, 1),
            ),
          );
          _ticketController.forward();
        },
        onPanStart: (DragStartDetails details) {
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
          // alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: FlareActor(
                'assets/background.flr',
                animation: 'jumping',
                controller: _ikController,
              ),
            ),
            Positioned.fill(
              child: FlarePseudo3DWidget(
                // fit: BoxFit.contain,
                // alignment: Alignment.center,
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
