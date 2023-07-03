import 'package:demo/common/entry_able.dart';
import 'package:flutter/material.dart';
import 'package:flutter_util/util/float_util.dart';
import 'package:flutter_util/widget/drag_widget.dart';

import '../common/common_button.dart';

GlobalKey globalFloatShowKey = GlobalKey();
GlobalKey globalFloatHiddenKey = GlobalKey();
class GlobalFloatWidget extends StatefulWidget {
  const GlobalFloatWidget({Key? key}) : super(key: key);

  @override
  State<GlobalFloatWidget> createState() => _GlobalFloatWidgetState();
}

class _GlobalFloatWidgetState extends State<GlobalFloatWidget> with EntryAble {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonButton(title: "开启悬浮按钮",onTap: show,key: globalFloatShowKey,),
        CommonButton(title: "关闭悬浮按钮",onTap: hidden,key: globalFloatHiddenKey,),
      ],
    );
  }

  @override
  void show() {
    entry ??= FloatUtil.addFloatWidget(context, child: Padding(
      padding: const EdgeInsets.all(50),
      child: DragWidget(
        padding: const EdgeInsets.all(20),
        initOffset: const Offset(10, 50),
        child: FloatingActionButton(
          onPressed: () {
            debugPrint("悬浮按钮点击");
          },
          child: const Icon(Icons.add),
        ),
      ),
    ));
  }
}

