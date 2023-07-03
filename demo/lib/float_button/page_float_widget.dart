import 'package:flutter/material.dart';
import 'package:flutter_util/widget/drag_widget.dart';

class PageFloatWidget extends StatelessWidget {
  const PageFloatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("单页面悬浮按钮"),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            child: Image.network(
              "https://img2.baidu.com/it/u=3853345508,384760633&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1200",
              fit: BoxFit.cover,
            ),
          ),
          DragWidget(
            padding: const EdgeInsets.all(20),
            initOffset: const Offset(10, 50),
            child: FloatingActionButton(
              onPressed: () {
                debugPrint("悬浮按钮点击");
              },
              child: const Icon(Icons.add),
            ),
          )
        ],
      ),
    );
  }
}
