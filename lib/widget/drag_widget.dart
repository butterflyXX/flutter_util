import 'package:flutter/material.dart';

class DragWidget extends StatefulWidget {
  final Offset initOffset;
  final Widget child;
  final EdgeInsets padding;
  final Duration? animationDuration;

  const DragWidget({
    this.initOffset = Offset.zero,
    required this.child,
    this.padding = EdgeInsets.zero,
    this.animationDuration,
    Key? key,
  }) : super(key: key);

  @override
  State<DragWidget> createState() => _DragButtonState();
}

class _DragButtonState extends State<DragWidget> {
  final _selfKey = GlobalKey();
  final _childKey = GlobalKey();
  late ValueNotifier<Offset> offset;
  Offset? offsetToZero;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    offset = ValueNotifier(widget.initOffset);
  }

  var duration = Duration.zero;
  static const _defAnimationDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      key: _selfKey,
      children: [
        ValueListenableBuilder<Offset>(
          valueListenable: offset,
          builder: (context, value, child) {
            return AnimatedPositioned(
              left: value.dx,
              top: value.dy,
              duration: duration,
              child: child!,
            );
          },
          child: GestureDetector(
            onVerticalDragStart: (detail) => startDrag(detail.globalPosition),
            onHorizontalDragStart: (detail) => startDrag(detail.globalPosition),
            onVerticalDragEnd: (_) => endDrag(),
            onHorizontalDragEnd: (_) => endDrag(),
            onVerticalDragUpdate: (detail) => updateOffset(detail.globalPosition),
            onHorizontalDragUpdate: (detail) => updateOffset(detail.globalPosition),
            child: Builder(
                key: _childKey,
                builder: (context) {
                  return widget.child;
                }),
          ),
        ),
      ],
    );
  }

  startDrag(Offset globalOffset) {
    offsetToZero ??= globalOffset - offset.value;
  }

  endDrag() {
    if (offsetToZero != null) {
      offsetToZero = null;
      final selfSize = _selfKey.currentContext?.size;
      final childSize = _childKey.currentContext?.size;
      if (selfSize != null && childSize != null) {
        final padding = widget.padding;
        final left = padding.left;
        final top = padding.top;
        final right = padding.right;
        final bottom = padding.bottom;
        double x = offset.value.dx;
        double y = offset.value.dy;

        if (offset.value.dx < left) {
          x = left;
        } else if (offset.value.dx > selfSize.width - childSize.width - right) {
          x = selfSize.width - childSize.width - right;
        }
        if (offset.value.dy < top) {
          y = top;
        } else if (offset.value.dy > selfSize.height - childSize.height - bottom) {
          y = selfSize.height - childSize.height - bottom;
        }

        final newOffset = Offset(x, y);
        if (offset.value != newOffset) {
          if (duration != (widget.animationDuration??_defAnimationDuration)) {
            duration = widget.animationDuration??_defAnimationDuration;
          }
          offset.value = newOffset;
        }
      }
    }
  }

  updateOffset(Offset globalOffset) {
    if (duration != Duration.zero) {
      duration = Duration.zero;
    }
    offset.value = globalOffset - offsetToZero!;
  }
}