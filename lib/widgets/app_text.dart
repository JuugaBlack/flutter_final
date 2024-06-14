import 'package:flutter/material.dart';

/// Normal 字体
class AppText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;

  const AppText(
    this.text, {
    super.key,
    this.size = 16,
    this.color = Colors.black54,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
      ),
    );
  }
}
