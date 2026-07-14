import 'package:flutter/material.dart';


class MyText extends StatefulWidget {
  final String text;
  final Color color;
  final double size;
  final bool bold;
  const MyText({super.key, required this.text, required this.color, required this.size, required this.bold});

  @override
  State<MyText> createState() => _MyTextState();
}

class _MyTextState extends State<MyText> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.text,
    style: TextStyle(
      color: widget.color,
      fontSize: widget.size,
      fontWeight: (widget.bold == true) ? FontWeight.bold : FontWeight.normal,
    ),
   );
  }
}