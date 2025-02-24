
import 'package:flutter/material.dart';
import 'package:note_trainer/UI/atoms/Countdown.dart';

class CountdownWrapper extends StatefulWidget {
  final int from;
  final TextStyle? countStyle;
  final Widget child;
  const CountdownWrapper({super.key, required this.from, required this.child, this.countStyle});

  @override
  State<CountdownWrapper> createState() => _CountdownWrapperState();
}

class _CountdownWrapperState extends State<CountdownWrapper> {
  bool _finished = false;

  @override
  Widget build(BuildContext context) {
    if(_finished){
      return widget.child;
    }
    return Countdown(from: widget.from, onCountdownFinished: () {
      setState(() {
        _finished = true;
      });
    }, countStyle: widget.countStyle,);
  }
}
