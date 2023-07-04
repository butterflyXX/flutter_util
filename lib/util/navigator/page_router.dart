import 'package:flutter/material.dart';

import 'route_page_mixin.dart';

typedef MyNavigatorRouteBuilder = Widget Function();

class PageRouter {
  static WidgetBuilder route({required MyNavigatorRouteBuilder builder}) {
    return (context) {
      final widget = builder();
      final params = ModalRoute.of(context)?.settings.arguments ?? {};
      if (params is Map<String, dynamic>) {
        if (widget is RoutePageMixin) {
          (widget as RoutePageMixin).params = params;
        }
      }
      return widget;
    };
  }
}