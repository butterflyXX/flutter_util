import 'package:flutter/material.dart';
import 'package:flutter_util/util/float_util.dart';

class LoadingUtil {
  static OverlayEntry show(BuildContext context,{
    String? msg,
    HitTestBehavior? behavior,
    Color? tintColor,
    Color? backgroundColor,
    Color? contentColor,
    Widget? loading,
    EdgeInsetsGeometry? padding,
  }) {
    return FloatUtil.addFloatWidget(context,
        child: LoadingWidget(
          msg: msg,
          behavior: behavior??HitTestBehavior.opaque,
          tintColor: tintColor,
          backgroundColor: backgroundColor,
          contentColor: contentColor,
          padding: padding,
          loading: loading,
        ));
  }

  static hidden(OverlayEntry entry) {
    entry.remove();
  }
}

class LoadingWidget extends StatelessWidget {
  final String? msg;
  final HitTestBehavior? behavior;
  final Color? tintColor;
  final Color? backgroundColor;
  final Color? contentColor;
  final Widget? loading;
  final EdgeInsetsGeometry? padding;

  const LoadingWidget({
    Key? key,
    this.msg,
    this.tintColor,
    this.behavior,
    this.backgroundColor,
    this.contentColor,
    this.padding,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Center(
      child: Container(
        padding: padding??const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: contentColor??Colors.black54,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            loading??CircularProgressIndicator(
              color: tintColor??Colors.white,
            ),
            Visibility(
              visible: msg?.isNotEmpty ?? false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    msg ?? "",
                    style: TextStyle(
                      color: tintColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    child = GestureDetector(
      behavior: behavior??HitTestBehavior.deferToChild,
      child: Material(child: child,color: backgroundColor??Colors.transparent,),
    );

    return child;
  }
}
