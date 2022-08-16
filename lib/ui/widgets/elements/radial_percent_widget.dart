import 'package:flutter/material.dart';
import 'dart:math' show pi;

import 'package:themoviedb/Theme/app_colors.dart';

class RadialPercentWidget extends StatelessWidget {
  final int score;

  const RadialPercentWidget({
    Key? key,
    required this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: CustomPaint(
        painter: _Painter(score: score / 100),
        child: Center(
          child: Text(
            '$score %',
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _Painter extends CustomPainter {
  final double score;

  _Painter({
    required this.score,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const double stroke = 4;
    const double padding = 3;

    drawBackground(canvas, size);
    drawFreeArc(stroke, canvas, padding, size);
    drawFillArc(stroke, canvas, padding, size);
  }

  void drawFillArc(double stroke, Canvas canvas, double padding, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;
    if (score <= 0.35) {
      paint.color = AppColors.scoreBad;
    } else if (score >= 0.7) {
      paint.color = AppColors.scoreGreat;
    } else {
      paint.color = AppColors.scoreGood;
    }

    canvas.drawArc(
      Offset(padding + stroke / 2, padding + stroke / 2) &
          Size(size.width - padding * 2 - stroke,
              size.height - padding * 2 - stroke),
      -pi / 2,
      2 * pi * score,
      false,
      paint,
    );
  }

  void drawFreeArc(double stroke, Canvas canvas, double padding, Size size) {
    final paint = Paint()
      ..color = Colors.lime.shade900.withOpacity(0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Offset(padding + stroke / 2, padding + stroke / 2) &
          Size(size.width - padding * 2 - stroke,
              size.height - padding * 2 - stroke),
      0,
      2 * pi,
      false,
      paint,
    );
  }

  void drawBackground(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.scoreBg;
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.height / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
