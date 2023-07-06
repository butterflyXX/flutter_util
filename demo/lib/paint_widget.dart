import 'dart:ui';

import 'package:flutter/material.dart';

class PaintWidget extends StatefulWidget {
  const PaintWidget({Key? key}) : super(key: key);

  @override
  State<PaintWidget> createState() => _PaintWidgetState();
}

class _PaintWidgetState extends State<PaintWidget> {
  var path = Path();

  paintNewPoint(Offset point) {
    path.moveTo(point.dx, point.dy);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('简单画板实现'),),
      body: Listener(
        onPointerDown: (PointerDownEvent event) {
          setState(() {
            path.moveTo(event.localPosition.dx, event.localPosition.dy);
          });
        },
        onPointerMove: (PointerMoveEvent event) {
          setState(() {
            path.lineTo(event.localPosition.dx, event.localPosition.dy);
          });
        },
        onPointerUp: (PointerUpEvent event) {
          setState(() {
            path.moveTo(event.localPosition.dx, event.localPosition.dy);
            path.close();
          });
        },
        child: CustomPaint(
          foregroundPainter: MyPainter(path),
          child: Container(color: Colors.green,),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.replay),
        onPressed: () {
          setState(() {
            path.reset();
          });
        },
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  Path path;
  MyPainter(this.path);
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.transparent, BlendMode.color);
    final paint = Paint()..color = Colors.black54
      ..strokeWidth = 5
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }

}
