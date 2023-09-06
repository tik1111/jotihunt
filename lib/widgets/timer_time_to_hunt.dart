// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TimerTimeToNextHunt extends StatefulWidget {
  final DateTime createdAt;

  const TimerTimeToNextHunt({super.key, required this.createdAt});

  @override
  _TimerTimeToNextHuntState createState() => _TimerTimeToNextHuntState();
}

class _TimerTimeToNextHuntState extends State<TimerTimeToNextHunt> {
  late Duration timeRemaining;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now();
    Duration timePassed = now.difference(widget.createdAt);
    timeRemaining = const Duration(hours: 1) - timePassed;

    if (timeRemaining.isNegative) {
      if (kDebugMode) {
        print("Hunt time");
      }
    } else {
      timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
    }
  }

  @override
  void didUpdateWidget(covariant TimerTimeToNextHunt oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.createdAt != widget.createdAt) {
      // Cancel the old timer
      timer?.cancel();

      DateTime now = DateTime.now();
      Duration timePassed = now.difference(widget.createdAt);
      timeRemaining = const Duration(hours: 1) - timePassed;

      if (timeRemaining.isNegative) {
        if (kDebugMode) {
          print("Hunt time");
        }
      } else {
        // Start a new timer
        timer = Timer.periodic(const Duration(seconds: 1), _updateTime);
      }
    }
  }

  void _updateTime(Timer timer) {
    if (mounted) {
      setState(() {
        if (timeRemaining.inSeconds == 0) {
          timer.cancel();
          if (kDebugMode) {
            print("Een uur is verstreken!");
          }
        } else {
          timeRemaining = timeRemaining - const Duration(seconds: 1);
        }
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (timeRemaining.isNegative) {
      return Container(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(
            color: Colors.grey.withOpacity(1),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: const Row(
          children: [
            Icon(
              Icons.verified,
              color: Colors.green,
            ),
            SizedBox(width: 8),
            Text(
              "Hunt time",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
        decoration: BoxDecoration(
          color: Colors.white70,
          border: Border.all(
            color: Colors.grey.withOpacity(1),
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.verified,
              color: Colors.red,
            ),
            const SizedBox(width: 8),
            Text(
              "Hunt: ${timeRemaining.inMinutes}:${(timeRemaining.inSeconds % 60).toString().padLeft(2, '0')}",
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      );
    }
  }
}