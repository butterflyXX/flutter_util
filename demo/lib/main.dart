import 'package:demo/float_button/global_float_widget.dart';
import 'package:demo/float_button/page_float_widget.dart';
import 'package:demo/loading/global_loading.dart';
import 'package:demo/mask_widget/masking.dart';
import 'package:demo/paint_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_util/util/life_cycle/life_cycle_notif.dart';
import 'package:flutter_util/util/navigator/navigator_util.dart';
import 'package:flutter_util/util/navigator/page_router.dart';
import 'package:flutter_util/widget/loading_widget.dart';

import 'common/common_button.dart';
import 'common/key.dart';
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
      navigatorKey: navigatorKey,
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
          testReOpenAppDoWork(),
          testPaint(),
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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PageFloatWidget(),
              ),
            );
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

  /// 测试在退出当前app后,又回来,如果之前有标记需要执行的任务,是否执行,并且执行一次,再次退出进入不在执行
  Widget testReOpenAppDoWork() {
    return Row(
      children: [
        CommonButton(
          title: "测试进入app任务是否执行",
          onTap: () {
            GlobalLifeCycleUtil.doWork(afterNeedDo: () {
              final entry = LoadingUtil.show(context);
              Future.delayed(const Duration(seconds: 2)).then((value) => LoadingUtil.hidden(entry));
            });
          },
        ),
      ],
    );
  }

  Widget testPaint() {
    return Row(
      children: [
        CommonButton(
          title: "测试画笔",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PaintWidget()));
          },
        ),
      ],
    );
  }
}
