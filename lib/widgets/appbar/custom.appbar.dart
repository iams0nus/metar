import 'dart:math';

import 'package:flutter/material.dart';
import 'package:metar/widgets/home.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.lastUpdated,
    required this.widget,
  }) : super(key: key);

  final String lastUpdated;
  final MyHomePage widget;
  @override
  Size get preferredSize => new Size.fromHeight(100);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Transform(
                transform: Matrix4.rotationY(pi),
                child: Icon(Icons.restore_rounded),
              ),
              Text(
                lastUpdated,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
      title: Text(
        widget.title,
        style: TextStyle(color: Colors.white),
      ),
      bottom: TabBar(
        tabs: [
          Tab(icon: Icon(Icons.local_airport)),
          Tab(icon: Icon(Icons.screenshot)),
        ],
      ),
    );
  }
}
