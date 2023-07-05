import 'package:flutter/cupertino.dart';

typedef TryErrorBlock = void Function(Object error,StackTrace detail);
class TryUtil {
  static doTry(VoidCallback work,{TryErrorBlock? errorBlock}) {
    try {
      work.call();
    }catch(error,detail){
      if (errorBlock != null) {
        errorBlock(error,detail);
      } else {
        debugPrintStack(stackTrace: detail,label: error.toString());
      }
    }
  }
}