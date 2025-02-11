import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class DrawingGame extends FlameGame with PanDetector {
  List<Offset> points = [];
  Color drawColor = Colors.blue; // Color por defecto

  void changeColor(Color newColor) {
    drawColor = newColor;
  }

  void clearCanvas() {
    points.clear();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    points.add(info.eventPosition.global.toOffset());
  }

  @override
  void render(Canvas canvas) {
    // Fondo blanco
    canvas.drawPaint(Paint()..color = Colors.white);

    // Dibujar los trazos
    final paint = Paint()
      ..color = drawColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }
}
