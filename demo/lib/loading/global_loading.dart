import 'package:demo/common/common_button.dart';
import 'package:demo/common/entry_able.dart';
import 'package:flutter/material.dart';
import 'package:flutter_util/util/float_util.dart';
import 'package:flutter_util/widget/loading_widget.dart';

class GlobalLoadingWidget extends StatefulWidget {
  const GlobalLoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<GlobalLoadingWidget> createState() => _GlobalLoadingWidgetState();
}

class _GlobalLoadingWidgetState extends State<GlobalLoadingWidget> with EntryAble {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonButton(title: "loading show", onTap: show),
        CommonButton(title: "loading hidden", onTap: hidden),
      ],
    );
  }

  @override
  void show() {
    entry ??= FloatUtil.addFloatWidget(context,
        child: const LoadingWidget(
          // msg: "loading...",
          contentColor: Colors.green,
          behavior: HitTestBehavior.opaque,
        ));
    Future.delayed(const Duration(seconds: 2)).then((value) => hidden());
  }
}
