import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_util/util/try.dart';

class GlobalLifeCycleUtil {

  /// 返回前台需要执行的回调(只执行一次,执行完清空)
  static List<VoidCallback> tasks = [];
  static bool hasInit = false;

  static void doWork({required VoidCallback afterNeedDo}) {
    if (!hasInit) initCallBack();
    tasks.add(afterNeedDo);
  }

  static void initCallBack() {
    if (hasInit) return;
    SystemChannels.lifecycle.setMessageHandler((message) async {
      if (tasks.isNotEmpty) {
        if (message == AppLifecycleState.resumed.toString()) {
          _doTask();
        }
      }
      return message;
    });
    hasInit = true;
  }

  static _doTask() async {
    for (final callBack in tasks) {
      TryUtil.doTry(()=>callBack.call());
    }
    tasks = [];
  }
}