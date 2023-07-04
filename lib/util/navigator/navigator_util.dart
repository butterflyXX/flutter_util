import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_util/util/navigator/route_page_mixin.dart';

class NavigatorUtil {
  static getUri(
    String route, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? statParams,
  }) {
    final encodeParams = {
      RoutePageMixin.paramsKey: jsonEncode(params ?? {}),
      RoutePageMixin.statParamsKey: jsonEncode(statParams ?? {}),
    };
    final uri = Uri.https("www.myTest.com", route, encodeParams);
    return uri;
  }

  static push(
    BuildContext context,
    String routeName, {
    Map<String, dynamic>? params,
    Map<String, dynamic>? statParams,
  }) {
    Navigator.of(context).pushNamed(routeName, arguments: {
      RoutePageMixin.paramsKey: params,
      RoutePageMixin.statParamsKey: statParams,
    });
  }

  static pushUri(BuildContext context, String uriString) {
    final decoded = Uri.decodeFull(uriString).replaceAll('#', '?');
    final uri = Uri.parse(decoded);
    final routName = uri.path;
    final params = jsonDecode(uri.queryParameters[RoutePageMixin.paramsKey] ?? "{}");
    final statParams = jsonDecode(uri.queryParameters[RoutePageMixin.statParamsKey] ?? "{}");

    Navigator.of(context).pushNamed(routName, arguments: {
      RoutePageMixin.paramsKey: params,
      RoutePageMixin.statParamsKey: statParams,
    });
  }
}
