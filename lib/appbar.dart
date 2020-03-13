import 'package:flutter/material.dart';
import 'dart:math' show min;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final double height, width;

  CustomAppBar({this.height, this.width});

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
          widthFactor: (widget.width > 720)
              ? 360 / widget.width
              : min(250, widget.width) / widget.width,
          child: AppBar(
            backgroundColor: const Color(0xfff06292),
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.info_outline,
                  size: 16.0,
                  color: const Color(0xfff48fb1),
                ),
                onPressed: () => setState(() => _visible = false),
              ),
            ],
            title: Text(
              'Thanks Ivan Bannikov!',
              style: TextStyle(
                  fontFamily: '.SF UI Text',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w100,
                  color: const Color(0xfffce4ec)),
            ),
          ),
        ),
      );
}
