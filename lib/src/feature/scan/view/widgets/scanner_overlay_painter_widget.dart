import 'package:flutter/material.dart';

class ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const scanSize = 280.0;
    const cornerLength = 36.0;
    const cornerRadius = 14.0;
    const strokeWidth = 3.5;

    final scanRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: scanSize,
      height: scanSize,
    );

    // --- Dim overlay with cutout ---
    final background = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    final cutOut = Path()
      ..addRRect(
        RRect.fromRectAndRadius(scanRect, const Radius.circular(cornerRadius)),
      );
    final overlayPath = Path.combine(
      PathOperation.difference,
      background,
      cutOut,
    );

    canvas.drawPath(
      overlayPath,
      Paint()..color = Colors.black.withValues(alpha: 0.6),
    );

    // --- Blue glow paint ---
    final glowPaint = Paint()
      ..color = const Color(0xFF2266FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    final solidPaint = Paint()
      ..color = const Color(0xFF66AAFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    _drawCorners(canvas, scanRect, cornerLength, cornerRadius, glowPaint);
    _drawCorners(canvas, scanRect, cornerLength, cornerRadius, solidPaint);

    // --- Bottom glow bar ---
    final barCenter = Offset(scanRect.center.dx, scanRect.bottom);
    final barPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.transparent,
          const Color(0xFF2266FF),
          const Color(0xFF66AAFF),
          const Color(0xFF2266FF),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCenter(center: barCenter, width: 140, height: 4))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawLine(
      Offset(barCenter.dx - 70, barCenter.dy),
      Offset(barCenter.dx + 70, barCenter.dy),
      barPaint,
    );
  }

  void _drawCorners(
    Canvas canvas,
    Rect rect,
    double length,
    double radius,
    Paint paint,
  ) {
    final l = rect.left;
    final t = rect.top;
    final r = rect.right;
    final b = rect.bottom;

    // Top-left
    canvas.drawPath(
      Path()
        ..moveTo(l, t + length)
        ..lineTo(l, t + radius)
        ..arcToPoint(Offset(l + radius, t), radius: Radius.circular(radius))
        ..lineTo(l + length, t),
      paint,
    );

    // Top-right
    canvas.drawPath(
      Path()
        ..moveTo(r - length, t)
        ..lineTo(r - radius, t)
        ..arcToPoint(Offset(r, t + radius), radius: Radius.circular(radius))
        ..lineTo(r, t + length),
      paint,
    );

    // Bottom-left
    canvas.drawPath(
      Path()
        ..moveTo(l, b - length)
        ..lineTo(l, b - radius)
        ..arcToPoint(
          Offset(l + radius, b),
          radius: Radius.circular(radius),
          clockwise: false,
        )
        ..lineTo(l + length, b),
      paint,
    );

    // Bottom-right
    canvas.drawPath(
      Path()
        ..moveTo(r - length, b)
        ..lineTo(r - radius, b)
        ..arcToPoint(
          Offset(r, b - radius),
          radius: Radius.circular(radius),
          clockwise: false,
        )
        ..lineTo(r, b - length),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
