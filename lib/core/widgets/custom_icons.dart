import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon(
      {super.key,
      required this.iconData,
      this.color = Colors.black,
      this.size,
      this.padding = 0});

  final IconData iconData;
  final Color color;
  final double? size;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Icon(
        iconData,
        color: color,
        size: size ?? MediaQuery.of(context).size.width * .05,
      ),
    );
  }
}
