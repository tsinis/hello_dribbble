import 'package:flare_flutter/flare_actor.dart' show FlareActor;
import 'package:flutter/material.dart';

import 'pseudo3D_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(home: const MyHomePage());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> pseudo3D, depth;
  double point = 0, turn = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this)
      ..addListener(() {
        setState(() {
          if (pseudo3D != null) {
            point *= pseudo3D.value;
            turn *= pseudo3D.value;
          }
        });
      });
    _controller.forward(from: 1);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color.fromRGBO(223, 125, 163, 1),
        body: GestureDetector(
          onPanUpdate: (DragUpdateDetails drag) {
            setState(() {
              var size = MediaQuery.of(context).size;
              point += drag.delta.dy * (1 / size.height);
              turn -= drag.delta.dx * (1 / size.width);
            });
          },
          onPanEnd: (DragEndDetails details) {
            pseudo3D = Tween<double>(
              begin: 1,
              end: 0,
            ).animate(_controller);
            depth = Tween<double>(
              begin: 1,
              end: 0,
            ).animate(
              CurvedAnimation(
                parent: _controller,
                curve: const Cubic(0.5, 0, 0.25, 1),
              ),
            );
            _controller.forward();
          },
          onPanStart: (DragStartDetails details) {
            pseudo3D = null;
            depth = Tween<double>(
              begin: 1,
              end: 0,
            ).animate(
              CurvedAnimation(
                parent: _controller,
                curve: const Cubic(1, 0, 1, 1),
              ),
            );
            _controller.reverse();
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: FlareActor(
                  'assets/background.flr',
                  animation: 'jumping',
                ),
              ),
              Positioned.fill(
                child: FlarePseudo3DWidget(
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  point: point,
                  turn: turn,
                  depth: depth?.value ?? 0,
                ),
              ),
            ],
          ),
        ),
      );
}
