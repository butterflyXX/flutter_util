import 'dart:convert';

import 'package:demo/float_button/global_float_widget.dart';
import 'package:demo/float_button/page_float_widget.dart';
import 'package:demo/loading/global_loading.dart';
import 'package:demo/mask_widget/masking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_util/util/navigator/navigator_util.dart';
import 'package:flutter_util/util/navigator/page_router.dart';

import 'common/common_button.dart';
import 'navigator_push_test/navigator_push_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": PageRouter.route(builder: () => const MyHomePage(title: '功能体验')),
        "/navigator_push_page": PageRouter.route(builder: () => NavigatorPushPage()),
      },
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
      precacheImage(
          const NetworkImage("https://t7.baidu.com/it/u=2749005241,3756993511&fm=193&f=GIF"),
          context);
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
          pageRouteWidget(),
        ],
      ),
    );
  }

  /// 单页面悬浮可拖拽按钮
  Widget pageFloatWidget() {
    return Row(
      children: [
        CommonButton(
          title: "单页面悬浮可拖拽按钮",
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const PageFloatWidget()));
          },
        ),
      ],
    );
  }

  /// 测试uri路由跳转
  Widget pageRouteWidget() {
    return Row(
      children: [
        CommonButton(
          title: "测试uri路由跳转",
          onTap: () {
            final uri = NavigatorUtil.getUri(
              "navigator_push_page",
              params: {
                "title": "测试uri路由跳转",
                "name": "小刘",
                "age": 20,
                "score": 89,
              },
              statParams: {"entry": "home"},
            );
            NavigatorUtil.pushUri(context, uri.toString());
          },
        ),
      ],
    );
  }
}
