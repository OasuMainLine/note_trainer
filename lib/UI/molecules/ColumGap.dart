import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
class ColumnGap extends StatelessWidget {
  final List<Widget> children;
  final double gap;
  const ColumnGap({super.key, required this.gap, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children.mapIndexed((i, child) {
        if(i == 0) {
          return child;
        }
        return Padding(padding: EdgeInsets.only(top: gap), child: child,);
      }).toList()
    );
  }
}
