import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class CircleTransitionPainter extends CustomPainter {
  CircleTransitionPainter({
    required Color backgroundColor,
    required Color currentCircleColor,
    required Color nextCircleColor,
    this.transitionPercent = 0,
  })  : backgroundPaint = Paint()..color = backgroundColor,
        currentCirclePaint = Paint()..color = currentCircleColor,
        nextCirclePaint = Paint()..color = nextCircleColor;

  final double baseCircleRadius = 36;
  final Paint currentCirclePaint;
  final Paint backgroundPaint;
  final Paint nextCirclePaint;
  final double transitionPercent;

  @override
  void paint(Canvas canvas, Size size) {
    if (transitionPercent < 0.5) {
      final double expansionPercent = transitionPercent / 0.5;
      paintExpansion(canvas, size, expansionPercent);
    } else {
      final double contractionPercent = (transitionPercent - 0.5) / 0.5;
      paintContraction(canvas, size, contractionPercent);
    }
  }

  void paintExpansion(Canvas canvas, Size size, double expansionPercent) {
    final double maxRadius = size.height * 200;
    Offset baseCircleCenter = Offset(size.width / 2, size.height * 0.76);
    final double circleLeftBound = baseCircleCenter.dx - baseCircleRadius;
    final num slowedExpansionPercent = pow(expansionPercent, 8);
    final double currentRadius =
        (maxRadius * slowedExpansionPercent) + baseCircleRadius;
    final Offset currentCircleCenter = Offset(
      circleLeftBound + currentRadius,
      baseCircleCenter.dy,
    );
    canvas.drawPaint(backgroundPaint);
    canvas.drawCircle(currentCircleCenter, currentRadius, currentCirclePaint);
    if (expansionPercent < 0.1) {
      paintChevron(canvas, baseCircleCenter, backgroundPaint.color);
    }
  }

  void paintContraction(Canvas canvas, Size size, double contractionPercent) {
    final double maxRadius = size.height * 200;
    Offset baseCircleCenter = Offset(size.width / 2, size.height * 0.76);
    final double circleStartingRightSide =
        baseCircleCenter.dx - baseCircleRadius;
    final double circleEndingRightSide = baseCircleCenter.dx + baseCircleRadius;
    final double easedContractionPercent =
        Curves.easeInOut.transform(contractionPercent);
    final double inversContractionPercent = 1 - contractionPercent;
    final num slowedInversContractionPercent = pow(inversContractionPercent, 8);
    final double currentRadius =
        (maxRadius * slowedInversContractionPercent) + baseCircleRadius;
    final double circleCurrentRightSide = circleStartingRightSide +
        ((circleEndingRightSide - circleStartingRightSide) *
            easedContractionPercent);
    final double circleCurrentCenterX = circleCurrentRightSide - currentRadius;
    final Offset currentCircleCenter = Offset(
      circleCurrentCenterX,
      baseCircleCenter.dy,
    );
    canvas.drawPaint(currentCirclePaint);
    canvas.drawCircle(currentCircleCenter, currentRadius, backgroundPaint);
    if (easedContractionPercent > 0.9) {
      double newCircleExpansionPercent = (easedContractionPercent - 0.9) / 0.1;
      double newCircleRadius = baseCircleRadius * newCircleExpansionPercent;
      canvas.drawCircle(currentCircleCenter, newCircleRadius, nextCirclePaint);
    }
    if (contractionPercent > 0.95) {
      paintChevron(canvas, baseCircleCenter, currentCirclePaint.color);
    }
  }

  void paintChevron(Canvas canvas, Offset circleCenter, Color color) {
    final IconData nextIcon = Icons.arrow_back_ios;
    final ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
      ui.ParagraphStyle(
        fontFamily: nextIcon.fontFamily,
        fontSize: 25,
        textAlign: TextAlign.center,
      ),
    )
      ..pushStyle(ui.TextStyle(color: color))
      ..addText(String.fromCharCode(nextIcon.codePoint));

    final ui.Paragraph paragraph = paragraphBuilder.build();
    paragraph.layout(ui.ParagraphConstraints(width: baseCircleRadius));
    canvas.drawParagraph(paragraph,
        circleCenter - Offset(paragraph.width / 2, paragraph.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
