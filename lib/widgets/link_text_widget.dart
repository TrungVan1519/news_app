import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LinkTextWidget extends StatefulWidget {
  const LinkTextWidget({
    super.key,
    this.onPressed,
    required this.intro,
    required this.link,
  });

  final Function()? onPressed;
  final String intro;
  final String link;

  @override
  State<LinkTextWidget> createState() => _LinkTextWidgetState();
}

class _LinkTextWidgetState extends State<LinkTextWidget> {
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: widget.intro,
            style: const TextStyle(color: Colors.black),
          ),
          TextSpan(
            text: widget.link,
            style: const TextStyle(color: Colors.blue),
            recognizer: TapGestureRecognizer()..onTap = widget.onPressed,
          ),
        ],
      ),
    );
  }
}
