import 'package:flutter/material.dart';

class ResizableContainer extends StatefulWidget {
  @override
  _ResizableContainerState createState() => _ResizableContainerState();
}

class _ResizableContainerState extends State<ResizableContainer> {
  double _width = 200.0;
  double _height = 200.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: (DragUpdateDetails details) {
        setState(() {
          _width += details.delta.dx;
          _height += details.delta.dy;
        });
      },
      child: Center(
        child: Transform(
          transform: Matrix4.identity()..scale(_width / 200, _height / 200),
          alignment: Alignment.topLeft,
          child: Container(
            color: Colors.blue,
            width: 200.0,
            height: 200.0,
            child: Center(
              child: Text(
                'Drag to resize',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}



//
// import 'package:flutter/material.dart';
//
// class ResizableWidget extends StatefulWidget {
//   @override
//   _ResizableWidgetState createState() => _ResizableWidgetState();
// }
//
// class _ResizableWidgetState extends State<ResizableWidget> {
//   double _scale = 1.0;
//   late Offset _startOffset;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onScaleStart: (details) {
//         _startOffset = details.focalPoint;
//       },
//       onScaleUpdate: (details) {
//         double dx = details.focalPoint.dx - _startOffset.dx;
//         double dy = details.focalPoint.dy - _startOffset.dy;
//         double distance = dx * dx + dy * dy;
//         double scale = 1.0;
//         if (distance > 0) {
//           scale = _scale + distance * 0.0001;
//         }
//         setState(() {
//           _scale = scale;
//         });
//       },
//       child: Transform.scale(
//         scale: _scale,
//         child: Container(
//           width: 200,
//           height: 200,
//           color: Colors.blue,
//         ),
//       ),
//     );
//   }
// }
