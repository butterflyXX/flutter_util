import 'dart:convert';

import 'dart:ui';

import 'package:flutter/material.dart';

class Tools {
  static bool? parseBool(dynamic value, {bool? def}) {
    if (value is bool) {
      return value;
    } else if (value is int) {
      return value != 0 ? true : false;
    } else if (value is String) {
      if (value.toLowerCase() == 't' ||
          value.toLowerCase() == 'true' ||
          value.toLowerCase() == 'y' ||
          value.toLowerCase() == 'yes' ||
          value.toLowerCase() == 'success'
      ) {
        return true;
      } else {
        return parseInt(value) == 1 ? true : false;
      }
    }
    return def;
  }

  static int? parseInt(dynamic num, {int? def}) {
    if (num is int) {
      return num;
    } else if (num is String) {
      return int.tryParse(num);
    } else if (num is double) {
      return num.toInt();
    }
    return def;
  }

  static double? parseDouble(dynamic num, {double? def}) {
    if (num is double) {
      return num;
    } else if (num is String) {
      return double.tryParse(num) ?? 0.0;
    } else if (num is int) {
      return num.toDouble();
    }
    return def;
  }

  static String? parseString(dynamic str, {String? def}) {
    if (str == null) {
      return def;
    }
    if (str is String) {
      return str;
    }
    return str.toString();
  }

  static Map<String, dynamic>? parseJsonMap(Map map) {
    Map<String, dynamic>? ret;
    try {
      if (map is Map) {
        ret = map.map((key, value) => MapEntry(Tools.parseString(key)!, value));
      }
    } catch (_) {}
    return ret;
  }

  static Map<String, String>? parseStringValueJsonMap(dynamic map) {
    Map<String, String> ret = {};
    try {
      if (map is Map) {
        ret = map.map((key, value) => MapEntry(Tools.parseString(key)!, Tools.parseString(value)!));
      }
    } catch (_) {}
    return ret;
  }

  static Map<dynamic, dynamic>? decodeJsonObj(String str) {
    Map<dynamic, dynamic>? ret;
    try {
      ret = jsonDecode(str);
    } catch (_) {}
    return ret;
  }

  static List<String?>? parseStringList(dynamic list) {
    if (list is List) {
      return list.map((item) => parseString(item)).toList();
    }
    return null;
  }

  static List<bool?>? parseBoolList(dynamic list) {
    if (list is List) {
      return list.map((item) => parseBool(item)).toList();
    }
    return null;
  }

  static List<int?>? parseIntList(dynamic list) {
    if (list is List) {
      return list.map((item) => parseInt(item)).toList();
    }
    return null;
  }

  static Color hexColor(String hexColor,{Color def = Colors.transparent}) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    hexColor = hexColor.replaceAll('0X', '');
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    final colorInt = int.tryParse(hexColor, radix: 16);
    return colorInt != null ? Color(colorInt) : def;
  }

  static bool isStringListEqual(List<String> a, List<String> b) {

    if (a.length != b.length) {
      return false;
    }

    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) {
        return false;
      }
    }
    return true;
  }

  /// 将字符串每一个字符都分开,可以保证换行都是规整的
  static String breakWord(String word) {
    if (word.isEmpty) {
      return word;
    }
    String breakWord = '';
    for (var element in word.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }
}

// 该扩展方便map使用tools解析字段
extension MapUseToolsParseExtension on Map {
  bool? getBool(String key) => Tools.parseBool(this[key]);
  int? getInt(String key) => Tools.parseInt(this[key]);
  double? getDouble(String key) => Tools.parseDouble(this[key]);
  String? getString(String key) => Tools.parseString(this[key]);
}