import 'package:flutter/material.dart';

enum ResizeDirection {

  resizeLeft,

  resizeRight,

  resizeTop,

  resizeBottom,

}


class ResizableComponent extends StatefulWidget {

  ResizeDirection resizeDirection;
  Widget? child;
  Color? color;
  double? width;
  double? minWidth;
  double? maxWidth;
  ResizableComponent({super.key,this.child,this.width,this.minWidth,this.maxWidth,this.color,this.resizeDirection = ResizeDirection.resizeLeft});

  @override
  _ResizableComponentState createState() => _ResizableComponentState();
}

class _ResizableComponentState extends State<ResizableComponent> {
  double _width = 20.0;
  double _height = 20.0;
  bool _isResizing = false;
  Offset _resizeStart = Offset.zero;

  @override
  void initState() {
    // if(widget.direction==null){
    //   widget.direction = Direction.left;
    // }
    if(widget.width!=null){
      _width = widget.width!;
    }
  }

  @override
  Widget build(BuildContext context) {

    BoxDecoration? boxDecoration = null;
    if(widget.resizeDirection==ResizeDirection.resizeLeft){
      boxDecoration =  BoxDecoration(
        color: widget.color,
        border:Border(
            left:BorderSide(
              color: Color.fromARGB(25, 0,0,0), // 边框颜色
              style: BorderStyle.solid, // 边框样式为实线
              width: 2,
            )
        ),
      );
    }else{
      boxDecoration =  BoxDecoration(
        color: widget.color,
        border:Border(
            right:BorderSide(
              color: Color.fromARGB(25, 0,0,0), // 边框颜色
              style: BorderStyle.solid, // 边框样式为实线
              width: 2,
            )
        ),
      );
    }

    return Listener(
      onPointerDown: (details) {
        setState(() {
          _isResizing = true;
          _resizeStart = details.localPosition;
          print(_resizeStart);
        });
      },
      onPointerMove: (details) {
        if (_isResizing) {
          setState(() {
            final offsetX = details.localPosition.dx - _resizeStart.dx;
            final offsetY = details.localPosition.dy - _resizeStart.dy;
            if(widget.resizeDirection==ResizeDirection.resizeRight){
              _width += offsetX;
              _height += offsetY;
            }else{
              _width -= offsetX;
              _height -= offsetY;
            }

            if (widget.minWidth!=null && _width<widget.minWidth!) {
              _width = widget.minWidth!;
            }
            if (widget.maxWidth!=null && _width>widget.maxWidth!) {
              _width = widget.maxWidth!;
            }
            _resizeStart = details.localPosition;
          });
        }
      },
      onPointerUp: (_) {
        setState(() {
          _isResizing = false;
        });
      },
      child: MouseRegion(
        cursor: (widget.resizeDirection==ResizeDirection.resizeRight?SystemMouseCursors.resizeRight:SystemMouseCursors.resizeLeft),
        child: Container(
          width: _width,
          padding: EdgeInsets.only(left: (widget.resizeDirection==ResizeDirection.resizeLeft?10:0),right: (widget.resizeDirection==ResizeDirection.resizeRight?10:0)),
          decoration:boxDecoration,
          child: MouseRegion(
            cursor:SystemMouseCursors.basic,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

