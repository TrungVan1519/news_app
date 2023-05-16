import 'package:flutter/material.dart';

class BottomAppBarItemWidget extends StatelessWidget {
  const BottomAppBarItemWidget({
    Key? key,
    required this.icon,
    this.index,
    this.onPressed,
  }) : super(key: key);

  final Widget icon;
  final int? index;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: onPressed, icon: icon);
  }
}
