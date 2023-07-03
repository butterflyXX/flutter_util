import 'package:flutter/material.dart';

class MaskWidgetController extends ValueNotifier<int> {
  MaskWidgetController({int index = 0}) : super(index);

  /// 上一个
  prev() {
    value--;
  }

  /// 下一个
  next() {
    value++;
  }

  /// 重置
  reset() {
    value = 0;
  }
}

class MaskWidget extends StatelessWidget {
  final EdgeInsets padding;
  final BorderRadius? borderRadius;
  final MaskWidgetController controller;
  final Color? backGroundColor;

  /// 需要被引导的组件context列表
  final List<BuildContext> targetContexts;

  MaskWidget({
    required this.targetContexts,
    MaskWidgetController? controller,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
    this.backGroundColor,
    Key? key,
  })  : controller = controller ?? MaskWidgetController(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        backGroundColor??Colors.black.withOpacity(.5),
        BlendMode.srcOut,
      ),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.transparent,
              backgroundBlendMode: BlendMode.dstOut,
            ),
          ),
          ValueListenableBuilder<int>(
            valueListenable: controller,
            builder: (context, index, child) {
              final rawIndex = index % targetContexts.length;
              final padding = this.padding;
              final left = padding.left;
              final top = padding.top;
              final right = padding.right;
              final bottom = padding.bottom;
              final renderBox = (targetContexts[rawIndex].findRenderObject() as RenderBox);
              return Positioned(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: borderRadius,
                  ),
                  width: renderBox.size.width + left + right,
                  height: renderBox.size.height + top + bottom,
                ),
                left: renderBox.localToGlobal(Offset.zero).dx - left,
                top: renderBox.localToGlobal(Offset.zero).dy - top,
              );
            },
          )
        ],
      ),
    );
  }
}
