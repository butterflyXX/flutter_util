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
              "https://t7.baidu.com/it/u=2749005241,3756993511&fm=193&f=GIF",
              fit: BoxFit.cover,
            ),
          ),
          DragWidget(
            padding: const EdgeInsets.all(20),
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
