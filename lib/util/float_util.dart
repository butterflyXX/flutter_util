import 'package:flutter/material.dart';

class FloatUtil {
  /// 获取悬浮OverlayEntry
  static OverlayEntry getDragEntry({required Widget child}) {
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) {
        return child;
      },
      opaque: false,
    );
    return entry;
  }

  /// 设置悬浮OverlayEntry
  static OverlayEntry addFloatWidget(BuildContext context, {required Widget child}) {
    final  entry = FloatUtil.getDragEntry(
      child: child,
    );
    Overlay.of(context)?.insert(entry);
    return entry;
  }
}