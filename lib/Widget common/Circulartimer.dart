import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularTimer extends StatefulWidget {
  final Duration duration;
  final Color color;
  final double strokeWidth;

  const CircularTimer({
    Key? key,
    required this.duration,
    this.color = Colors.blue,
    this.strokeWidth = 10.0,
  }) : super(key: key);

  @override
  _CircularTimerState createState() => _CircularTimerState();
}

class _CircularTimerState extends State<CircularTimer> {
  late Timer _timer;
  double _elapsedSeconds = 0.0;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      setState(() {
        if (_elapsedSeconds >= widget.duration.inSeconds) {
          timer.cancel();
        } else {
          _elapsedSeconds += 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CircularTimerPainter(
        duration: widget.duration,
        elapsedSeconds: _elapsedSeconds,
        color: widget.color,
        strokeWidth: widget.strokeWidth,
      ),
    );
  }
}

class _CircularTimerPainter extends CustomPainter {
  final Duration duration;
  final double elapsedSeconds;
  final Color color;
  final double strokeWidth;

  _CircularTimerPainter({
    required this.duration,
    required this.elapsedSeconds,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double progress = elapsedSeconds / duration.inSeconds;
    final double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * progress;

    final Rect rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(_CircularTimerPainter oldDelegate) {
    return elapsedSeconds != oldDelegate.elapsedSeconds;
  }
}
