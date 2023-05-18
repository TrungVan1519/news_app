import 'package:flutter/material.dart';

class TextTitleWidget extends StatefulWidget {
  const TextTitleWidget({
    super.key,
    this.text,
    this.alt,
  });

  final String? text;
  final String? alt;

  @override
  State<TextTitleWidget> createState() => _TextTitleWidgetState();
}

class _TextTitleWidgetState extends State<TextTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text ?? widget.alt ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
