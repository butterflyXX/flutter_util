import 'package:demo/common/common_button.dart';
import 'package:demo/common/entry_able.dart';
import 'package:demo/float_button/global_float_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_util/util/float_util.dart';
import 'package:flutter_util/widget/mask_widget.dart';

class MaskTestWidget extends StatefulWidget {
  const MaskTestWidget({Key? key}) : super(key: key);

  @override
  State<MaskTestWidget> createState() => _MaskTestWidgetState();
}

class _MaskTestWidgetState extends State<MaskTestWidget> with EntryAble {
  GlobalKey key = GlobalKey();
  final controller = MaskWidgetController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CommonButton(
          title: "引导蒙层",
          onTap: show,
          key: key,
        ),
      ],
    );
  }

  @override
  show() {
    final list = [key.currentContext!,globalFloatShowKey.currentContext!,globalFloatHiddenKey.currentContext!];
    entry ??= FloatUtil.addFloatWidget(
      context,
      child: GestureDetector(
        onTap: () {
          if (controller.value >= list.length-1) {
            hidden();
          } else {
            controller.next();
          }
        },
        child: MaskWidget(
          backGroundColor: Colors.blue.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
          controller: controller..reset(),
          targetContexts: list,
        ),
      ),
    );
  }
}
