import 'dart:typed_data';

import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class Stroke {
  final List<Offset> points;
  final Color color;

  Stroke({required this.points, required this.color});
}

class DrawingGame extends FlameGame with PanDetector {
  List<Stroke> strokes = [];
  List<Offset> currentPoints = [];

  Color drawColor = Colors.blue;
  final ui.PictureRecorder _pictureRecorder = ui.PictureRecorder();
  late final Canvas canvas;

  DrawingGame() {
    canvas = Canvas(_pictureRecorder);
  }

  void changeColor(Color newColor) {
    drawColor = newColor;
  }

  void clearCanvas() {
    strokes.clear();
    currentPoints.clear();
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    currentPoints.add(info.eventPosition.global.toOffset());
  }

  @override
  void onPanEnd(DragEndInfo info) {
    strokes.add(Stroke(points: List.from(currentPoints), color: drawColor));
    currentPoints.clear();
  }

  Future<ui.Image> _captureImage() async {
    final picture = _pictureRecorder.endRecording();
    return await picture.toImage(size.x.toInt(), size.y.toInt());
  }

  Future<Uint8List?> exportImage() async {
    try {
      final recorder = ui.PictureRecorder();
      final exportCanvas = Canvas(recorder);

      // Fondo blanco
      exportCanvas.drawPaint(Paint()..color = Colors.white);

      // Dibujar los trazos guardados
      for (final stroke in strokes) {
        final paint = Paint()
          ..color = stroke.color
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round;

        for (int i = 0; i < stroke.points.length - 1; i++) {
          exportCanvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
        }
      }

      // Dibujar el trazo en curso
      final currentPaint = Paint()
        ..color = drawColor
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round;

      for (int i = 0; i < currentPoints.length - 1; i++) {
        exportCanvas.drawLine(
            currentPoints[i], currentPoints[i + 1], currentPaint);
      }

      final picture = recorder.endRecording();
      final image = await picture.toImage(size.x.toInt(), size.y.toInt());
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('❌ Error al exportar imagen: $e');
      return null;
    }
  }

  @override
  void render(Canvas canvas) {
    canvas.drawPaint(Paint()..color = Colors.white);

    for (final stroke in strokes) {
      final paint = Paint()
        ..color = stroke.color
        ..strokeWidth = 5
        ..strokeCap = StrokeCap.round;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
      }
    }

    // También renderizamos el trazo en curso
    final paint = Paint()
      ..color = drawColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < currentPoints.length - 1; i++) {
      canvas.drawLine(currentPoints[i], currentPoints[i + 1], paint);
    }
  }
}
