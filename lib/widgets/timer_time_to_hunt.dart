import 'dart:async';
import 'package:flutter/material.dart';

class TimerTimeToNextHunt extends StatefulWidget {
  final DateTime createdAt;

  TimerTimeToNextHunt({required this.createdAt});

  @override
  _TimerTimeToNextHuntState createState() => _TimerTimeToNextHuntState();
}

class _TimerTimeToNextHuntState extends State<TimerTimeToNextHunt> {
  late Duration timeRemaining;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    Duration timePassed = now.difference(widget.createdAt);
    timeRemaining = Duration(hours: 1) - timePassed;

    if (timeRemaining.isNegative) {
      print("Hunt time");
    } else {
      timer = Timer.periodic(Duration(seconds: 1), _updateTime);
    }
  }

  @override
  void didUpdateWidget(covariant TimerTimeToNextHunt oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.createdAt != widget.createdAt) {
      // Cancel the old timer
      timer.cancel();

      // Calculate the new time remaining based on the new createdAt value
      DateTime now = DateTime.now();
      Duration timePassed = now.difference(widget.createdAt);
      timeRemaining = Duration(hours: 1) - timePassed;

      if (timeRemaining.isNegative) {
        print("Hunt time");
      } else {
        // Start a new timer
        timer = Timer.periodic(Duration(seconds: 1), _updateTime);
      }
    }
  }

  void _updateTime(Timer timer) {
    setState(() {
      if (timeRemaining.inSeconds == 0) {
        timer.cancel();
        print("Een uur is verstreken!");
      } else {
        timeRemaining = timeRemaining - Duration(seconds: 1);
      }
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (timeRemaining!.isNegative) {
      return Text(
        "Hunt time",
        style: TextStyle(fontSize: 18),
      );
    } else {
      return Text(
        "Hunt over: ${timeRemaining!.inMinutes}:${(timeRemaining!.inSeconds % 60).toString().padLeft(2, '0')}",
        style: TextStyle(fontSize: 18),
      );
    }
  }
}
