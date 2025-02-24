import 'package:flutter/material.dart';

class ButtonWrapper extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double width;

  const ButtonWrapper({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.symmetric(vertical: 0, horizontal: 48.0),
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.width,
      child: Padding(padding: padding, child: this.child),
    );
  }
}
