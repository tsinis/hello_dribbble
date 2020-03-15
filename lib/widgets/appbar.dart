import 'dart:math' show min;

import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({this.height, this.width});

  final double height, width;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) => Visibility(
        visible: _visible,
        child: FractionallySizedBox(
          widthFactor: (widget.width > 720.0)
              ? 360.0 / widget.width
              : min(250.0, widget.width) / widget.width,
          child: AppBar(
            backgroundColor: const Color(0xfff26d9a),
            elevation: 2.0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.info_outline,
                  size: 16.0,
                  color: const Color(0xfff48fb1),
                ),
                onPressed: () => setState(() => _visible = false),
              ),
            ],
            title: Align(
              alignment: Alignment.center,
              child: const Text(
                'Thanks Ivan Bannikov!',
                textScaleFactor: 1.0,
                style: const TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w100,
                  color: const Color(0xfffce4ec),
                ),
              ),
            ),
          ),
        ),
      );
}
