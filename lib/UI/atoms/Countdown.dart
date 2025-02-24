
import 'dart:async';

import 'package:flutter/material.dart';

class Countdown extends StatefulWidget {
  final int from;
  final Function onCountdownFinished;
  final TextStyle? countStyle;
  const Countdown({super.key,
    required this.from,
    required this.onCountdownFinished,
    this.countStyle
  });

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  int _count = 0;
  Timer? countdownTimer;

  final defaultStyle = TextStyle();
  @override
  void initState() {
    if(widget.from <= 0) {
      throw new Exception("${widget.from} can't be less than 0");
    }
    super.initState();
    this._count = widget.from;
    countdownTimer = Timer.periodic(Duration(seconds: 1), _onTick);
  }

  void _onTick(Timer timer){
      int nextCount = _count - 1;
      if(nextCount == 0) {
          timer.cancel();
          widget.onCountdownFinished();
      }
      setState(() {
          _count = nextCount;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Text(_count.toString(), style: defaultStyle.merge(widget.countStyle),);
  }
}
