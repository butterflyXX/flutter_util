import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final String? msg;
  final HitTestBehavior behavior;
  final Color tintColor;
  final Color backgroundColor;
  final Color contentColor;

  const LoadingWidget({
    Key? key,
    this.msg,
    this.tintColor = Colors.white,
    this.behavior = HitTestBehavior.deferToChild,
    this.backgroundColor = Colors.transparent,
    this.contentColor = Colors.black54,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget child = Center(
      child: Container(
        decoration: BoxDecoration(
          color: contentColor,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 100,
        width: 100,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: tintColor,
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
      ),
    );
    child = GestureDetector(
      behavior: behavior,
      child: Container(
        color: backgroundColor,
        child: Material(child: child,color: backgroundColor,),
      ),
    );

    return child;
  }
}
