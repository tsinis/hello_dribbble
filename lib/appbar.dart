import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Visibility(
      visible: _visible,
      child: FractionallySizedBox(
        widthFactor: (widget.width > 720) ? 0.33 : 1,
        child: AppBar(
          backgroundColor: Colors.pink[300],
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          actions: <Widget>[
            // action button
            IconButton(
                icon: Icon(
                  Icons.info_outline,
                  size: 16,
                  color: Colors.pinkAccent[100],
                ),
                onPressed: () => setState(() => _visible = false)),
          ],
          title: Text(
            'Thanks Ivan Bannikov!',
            style: TextStyle(
                fontFamily: '.SF UI Text',
                fontSize: 15,
                fontWeight: FontWeight.w100,
                color: Colors.pink[50]),
          ),
        ),
      ),
    );
  }
}
