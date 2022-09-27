import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final IconData? icon;
  const MyFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      label: Text(text),
      icon: Icon(icon),
      backgroundColor: Colors.blue,
    );
  }
}
