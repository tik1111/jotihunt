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
    _setupTimer();
  }

  void _setupTimer() {
    if (widget.createdAt != DateTime(0)) {
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
    } else {
      timeRemaining = const Duration(
          seconds: -1); // Zet de timer op 0 als er geen "hunt" is.
    }
  }

  @override
  void didUpdateWidget(covariant TimerTimeToNextHunt oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.createdAt != widget.createdAt) {
      timer?.cancel(); // Annuleer de oude timer.
      _setupTimer(); // Stel de nieuwe timer in.
    }
  }

  void _updateTime(Timer timer) {
    if (mounted) {
      setState(() {
        if (timeRemaining.inSeconds <= 0) {
          timer.cancel();
          // ignore: prefer_const_constructors
          timeRemaining = Duration(seconds: -1);
          if (kDebugMode) {
            print("Een uur is verstreken!");
          }
          setState(() {}); // Force rebuild
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
