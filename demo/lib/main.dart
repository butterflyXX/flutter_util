import 'package:demo/float_button/global_float_widget.dart';
import 'package:demo/float_button/page_float_widget.dart';
import 'package:demo/loading/global_loading.dart';
import 'package:demo/mask_widget/masking.dart';
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
      precacheImage(const NetworkImage("https://t7.baidu.com/it/u=2749005241,3756993511&fm=193&f=GIF"), context);
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
          const GlobalLoadingWidget(),
          const MaskTestWidget(),
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
