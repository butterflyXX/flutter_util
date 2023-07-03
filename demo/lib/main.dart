import 'package:demo/float_button/global_float_widget.dart';
import 'package:demo/float_button/page_float_widget.dart';
import 'package:flutter/material.dart';

import 'common/common_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      // 图片预加载
      precacheImage(const NetworkImage("https://img2.baidu.com/it/u=3853345508,384760633&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=1200"), context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: [
          const GlobalFloatWidget(),
          pageFloatWidget(),
        ],
      ),
    );
  }

  /// 单页面悬浮可拖拽按钮
  Widget pageFloatWidget() {
    return Row(
      children: [
        CommonButton(title: "单页面悬浮可拖拽按钮",onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PageFloatWidget()));
        },),
      ],
    );
  }
}
